class TraitsController < ApplicationController
  before_action :editor, except: [:index, :show, :export]
  before_action :set_trait, only: [:show, :edit, :update, :destroy, :duplicates, :meta, :resources]
  before_action :admin_user, only: :destroy

  skip_before_action :verify_authenticity_token, :only => [:update]

  def index
    @search = Trait.search do
      fulltext params[:search]

      if params[:all]
        paginate page: params[:page], per_page: 9999
      else
        paginate page: params[:page]
      end
    end
    @traits = @search.results

    respond_to do |format|
      format.html
      format.csv { send_data Trait.all.to_csv }
    end    
  end

  def resources
    @resources = Resource.where("id IN (?)", Observation.joins(:measurements).where("trait_id = ?", @trait.id).map(&:resource_id).uniq)

    respond_to do |format|
      format.html
    end
  end

  def overview
    query = Trait.all
    query = query.where("released = ?", params[:released]) #if not params[:released].blank?
    @traits = query.all

    respond_to do |format|
      format.html
    end    
  end

  def export
    @observations = Observation.joins(:measurements).where(:measurements => {:trait_id => params[:checked]})
    @observations = observation_filter(@observations)
    if params[:checked] and @observations.present?
      send_zip(@observations)
    else
      redirect_to traits_url, flash: {danger: "Nothing to download." }
    end
  end

  def export_release
    @observations = Observation.where(:access => true).joins(:measurements).where(:measurements => {:trait_id => Trait.where(:released => true)})
    if @observations.present?
      send_zip(@observations)
    else
      redirect_to releases_url, flash: {danger: "Nothing to release." }
    end
  end

  def show
    if params[:specie_id]
      @specie = Specie.find(params[:specie_id])
      @observations = Observation.includes(:specie).joins(:measurements).where('observations.specie_id = ? AND measurements.trait_id = ?', @specie.id, @trait.id)
    else
      @observations = Observation.joins(:measurements).where('measurements.trait_id = ?', @trait.id)
    end

    if params[:value]
      @observations = @observations.joins(:measurements).where('measurements.value = ?', params[:value])
    end

    if @trait.traitvalues.present?
      @mea_traitvalues = Measurement.where('trait_id = ?', @trait.id).map(&:value).uniq
      @rec_traitvalues = @trait.traitvalues.map(&:value_name).uniq
    end

    @observations = observation_filter(@observations)

    @methodologies = Methodology.where(:id => Measurement.where("observation_id IN (?) AND trait_id = ?", @observations.map(&:id), @trait.id).map(&:methodology_id))
    @standards = Standard.where(:id => Measurement.where("observation_id IN (?) AND trait_id = ?", @observations.map(&:id), @trait.id).map(&:standard_id))
    
    data_table = GoogleVisualr::DataTable.new

    if @trait.standard
      if @trait.standard.standard_unit != "id" && @trait.standard.standard_unit != "text"
        if @trait.standard.standard_class == "Nominal class" || @trait.standard.standard_name == "Category" || @trait.standard.standard_name == "Binomial"
          data_table.new_column('string')
          data_table.new_column('number')

          @trait.measurements.collect(&:value).uniq.each do |i|
            data_table.add_row([i, @trait.measurements.where("value LIKE ?", i).size])
          end
          option = { width: 250, height: 250, legend: 'none' }
          @chart = GoogleVisualr::Interactive::PieChart.new(data_table, option)
        else
          data_table.new_column('number')

          p = 0
          @trait.measurements.each do |i|
            if @trait.log_data
              data_table.add_row([Math.log10(i.value.to_d)])
            else
              data_table.add_row([i.value.to_d])
            end
          end
          if @trait.log_data
            option = { width: 250, height: 250, legend: 'none', :vAxis => { :title => "Frequency" }, :hAxis => { :title => "#{@trait.trait_name} (#{@trait.standard.standard_unit}), log10" } }
          else
            option = { width: 250, height: 250, legend: 'none', :vAxis => { :title => "Frequency" }, :hAxis => { :title => "#{@trait.trait_name} (#{@trait.standard.standard_unit})" } }
          end
          @chart = GoogleVisualr::Interactive::Histogram.new(data_table, option)
        end
     end
   end

    respond_to do |format|
      format.html { @observations = @observations.paginate(page: params[:page]) }
      format.csv { download_observations(@observations) }
      format.zip { send_zip(@observations) }
    end

  end

  def meta
    query = Trait.all
    query = query.editor(params[:editor]) if not params[:editor].blank?
    query = query.where(:released => params[:release_status]) if not params[:release_status].blank?
    @traits = query.all
  end

  def duplicates

    puts "==============================="
    @duplicates = Observation.joins(:measurements).select("specie_id, resource_id, location_id, trait_id, standard_id, value, array_agg(observation_id) as ids").where("trait_id = ?", params[:id]).where("trait_id NOT IN (?) AND valuetype_id NOT IN (?)", Trait.joins(:traitclass).where("class_name = 'Contextual'").map(&:id), Valuetype.where(has_precision: false).map(&:id)).group(:specie_id, :resource_id, :location_id, :trait_id, :standard_id, :value).having("count(*) > 1")

    puts @duplicates.length
    puts "==============================="

    respond_to do |format|
      format.html { }
      format.json { 
        render json: { dups: @duplicates.length }
      }
    end
  end

  def new
    @trait = Trait.new
  end

  def edit
  end

  def create
    @trait = Trait.new(trait_params)

    if @trait.save
      redirect_to @trait, flash: {success: "Trait was successfully created." }
    else
      render action: 'new' 
    end
  end

  def update    
    if @trait.update(trait_params)
      redirect_to @trait, flash: {success: "Trait was successfully updated." }
    else
      render action: 'edit'
    end
  end

  def destroy
    @trait.destroy
    respond_to do |format|
      format.html { redirect_to traits_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trait
      @trait = Trait.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trait_params
      params.require(:trait).permit(:trait_name, :trait_description, :traitclass_id, :value_range, :standard_id, :user_id, :approved, :released, :methodologies, :hide, :log_data, traitvalues_attributes: [:id, :value_name, :value_description, :_destroy])
    end
end


