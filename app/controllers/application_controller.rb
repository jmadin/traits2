class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  WillPaginate.per_page = 25
  Sunspot.config.pagination.default_per_page = 25

  before_action :set_last_seen_at, if: proc { |p| logged_in? && (session[:last_seen_at] == nil || session[:last_seen_at] < 15.minutes.ago) }

  def update_values
    @values = Trait.find(params[:trait_id]).value_range.split(',').map(&:strip)
    @standard = Standard.find(Trait.find(params[:trait_id]).standard_id)
  end

  def observation_filter(observations)
    if logged_in?
      if current_user.admin?
        observations = observations
      elsif current_user.editor? | current_user.contributor?
        observations = observations.where("observations.access = ? OR (observations.user_id = ? AND observations.access = ?)", true, current_user.id, false)
      else
        observations = observations.where("observations.access = ?", true)
      end
    else
      observations = observations.where("observations.access = ?", true)
    end

    if observations.present?
      observations = observations.order_species
    end
    observations
  end

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to(root_url)
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url, flash: {danger: "You can't access other user pages." }) unless (current_user?(@user) || current_user.admin?)
  end

  def admin_user
      redirect_to(root_url) unless logged_in? && current_user.admin?
  end

  def contributor
      redirect_to(
        root_url, flash: {danger: "You need to be a contributor to access this area of the database." }
      ) unless (logged_in? && (current_user.contributor? || current_user.admin?))
  end

  def editor
      redirect_to(
        root_url,flash: {danger: "You need to be a editor to access this area of the database." }
      ) unless (logged_in? && (current_user.editor? || current_user.admin?))
  end

  def enterer
    @observation = Observation.find(params[:id]) if params[:id]
    if @observation
      redirect_to(
        root_url, flash: { danger: "You can't edit or delete other peoples' observations." }
      ) unless (logged_in? && ((@observation.user_id == current_user.id) || current_user.admin?))
    else
      redirect_to(
        root_url, flash: { danger: "You need to become a contributor to access this area of the database." }
      ) unless (logged_in? && current_user.contributor?)
    end
  end


  # get ip of the user for versioning database
  def info_for_paper_trail
    # Save additional info
    { ip: request.remote_ip }
  end

  def user_for_paper_trail
    # Save the user responsible for the action
    logged_in? ? current_user.id : 'Guest'
  end


  def download_observations(observations)
    if request.url.include? 'resources.csv'
      csv_string = export_resources(observations)
      filename = 'resources'
    else
      csv_string = export_data(observations)
      filename = 'data'
    end
    send_data csv_string,
      :type => 'text/csv; charset=iso-8859-1; header=present', :stream => true,
      :disposition => "attachment; filename=#{filename}_#{Date.today.strftime('%Y%m%d')}.csv"
  end

  # NEW EXPORTER

  def export_resources(observations)

    ids = observations.map{|f| [f.resource_id, f.resource_secondary_id]}.uniq.compact
    resources = Resource.where(:id => ids)

    header = ["id", "author", "year", "title", "doi_isbn", "journal", "volume_pages"]
    csv_string = CSV.generate do |csv|
      csv << ["resource_id", "author", "year", "title", "doi_isbn", "journal", "volume_pages"]
      resources.each do |obs|
        csv << obs.attributes.values_at(*header)
      end
    end

    return csv_string
  end

  def export_data(observations)
    ids = observations.map(&:id).join(',')

    observations = Observation.find_by_sql("SELECT
      obs.id AS observation_id,
      obs.access AS access,
      obs.user_id, obs.specie_id, spe.specie_name, obs.location_id, loc.location_name,
      CASE WHEN loc.latitude=0 THEN NULL ELSE loc.latitude END AS latitude,
      CASE WHEN loc.longitude=0 THEN NULL ELSE loc.longitude END AS longitude,
      obs.resource_id, obs.resource_secondary_id,
      mea.id AS measurement_id,
      mea.trait_id, tra.trait_name,
      tcl.class_name AS trait_class_name,
      mea.standard_id, sta.standard_unit,
      mea.methodology_id, meth.methodology_name,
      mea.value,
      vty.value_type_name AS value_type_name,
      mea.precision,
      pty.precision_type_name AS precision_type_name,
      mea.precision_upper, mea.replicates,
      mea.measurement_description AS notes
      FROM observations AS obs
        INNER JOIN species AS spe
            ON spe.id = obs.specie_id
        INNER JOIN locations AS loc
            ON loc.id = obs.location_id
        INNER JOIN measurements AS mea
            ON mea.observation_id = obs.id
        INNER JOIN traits AS tra
            ON mea.trait_id = tra.id
        LEFT OUTER JOIN traitclasses AS tcl
            ON tra.traitclass_id = tcl.id
        INNER JOIN valuetypes AS vty
            ON mea.valuetype_id = vty.id
        LEFT OUTER JOIN precisiontypes AS pty
            ON mea.precisiontype_id = pty.id
        INNER JOIN standards AS sta
            ON mea.standard_id = sta.id
        LEFT OUTER JOIN methodologies AS meth
            ON mea.methodology_id = meth.id
      WHERE obs.id IN (#{ids})
      ORDER BY obs.id;")

    header = ["observation_id", "access", "user_id", "specie_id", "specie_name", "location_id", "location_name", "latitude", "longitude", "resource_id", "resource_secondary_id", "measurement_id", "trait_id", "trait_name", "trait_class_name", "standard_id", "standard_unit", "methodology_id", "methodology_name", "value", "value_type_name", "precision", "precision_type_name", "precision_upper", "replicates", "notes"]

    csv_string = CSV.generate do |csv|
      csv << header
      observations.each do |obs|
        csv << obs.attributes.values_at(*header)
      end
    end

    return csv_string
  end

  def send_zip(observations)

    data_csv_string = export_data(observations)
    data_file_path = "public/data.csv"
    _file1 = File.open(data_file_path, "w") { |f| f << data_csv_string }

    resources_csv_string = export_resources(observations)
    resources_file_path = "public/resources.csv"
    _file2 = File.open(resources_file_path, "w") { |f| f << resources_csv_string }

    # Combine file1 and file2 into zip file
    zipfile_name = 'zippedfiles.zip'
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      zipfile.add("data_#{Date.today.strftime('%Y%m%d')}.csv", data_file_path)
      zipfile.add("resources_#{Date.today.strftime('%Y%m%d')}.csv", resources_file_path)
    end

    File.open(zipfile_name, 'r') do |f|
      send_data f.read, type: "application/zip", :stream => true,
      :disposition => "attachment; filename = export_#{Date.today.strftime('%Y%m%d')}.zip"
    end
    File.delete(zipfile_name)
    FileUtils.rm_f(data_file_path)
    FileUtils.rm_f(resources_file_path)

  end

  def upload_csv
    @name = params[:controller]
  end

  private

    def set_last_seen_at
      current_user.update_attribute(:last_seen_at, Time.now)
      session[:last_seen_at] = Time.now
    end

end
