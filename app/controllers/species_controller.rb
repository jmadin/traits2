class SpeciesController < ApplicationController

  before_action :contributor, except: [:index, :show, :export]
  before_action :set_specie, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:destroy, :new, :create, :edit, :update]

  require 'savon'

  # GET /species
  # GET /species.json
  def index
    @search = Specie.search do
      fulltext params[:search]
      order_by :specie_name_sortable, :asc
      
      if params[:all]
        paginate page: params[:page], per_page: 9999
      else
        paginate page: params[:page]
      end
    end
    @species = @search.results

    respond_to do |format|
      format.html
      format.csv { send_data get_specie_csv }
    end    
  end

  def export
    if params[:checked]
      @observations = Observation.where(:specie_id => params[:checked])
      send_zip(@observations)          
    else
      redirect_to species_url, flash: {danger: "Nothing selected." }
    end
  end

  def show
    @map_files = Dir.glob("app/assets/images/*")

    @observations = Observation.where(:specie_id => @specie.id)
    @observations = observation_filter(@observations)

    respond_to do |format|
      format.html
      format.csv { download_observations(@observations) }
      format.zip { send_zip(@observations) }
    end
  end

  def new
    @specie = Specie.new
  end

  def edit
  end

  def create
    @specie = Specie.new(specie_params)
    if @specie.specie_name.present?
      begin
        client = Savon.client(
            :wsdl => "http://www.marinespecies.org/aphia.php?p=soap&wsdl=1",
            :open_timeout => 10,
            :read_timeout => 10,
            :log => false
        )
        @aphia = client.call(:get_aphia_id, message: { scientificname: "#{@specie.specie_name}" })
      rescue
        @specie_name = "Invalid"
        @specie.errors.add(:base, 'Server not responding')
      end
      @aphia_id = @aphia.body[:get_aphia_id_response][:return]
      if not @aphia_id.is_a?(Hash)
        @specie.aphia_id = @aphia_id
      else
        @specie.aphia_id = nil
      end
    end
    if @specie.aphia_id.present?
      begin
        client = Savon.client(
            :wsdl => "http://www.marinespecies.org/aphia.php?p=soap&wsdl=1",
            :open_timeout => 10,
            :read_timeout => 10,
            :log => false
        )
        @aphia = client.call(:get_aphia_name_by_id, message: { id: "#{@specie.aphia_id}" })
      rescue
        @aphia = "Invalid"
        @specie.errors.add(:aphia_id, 'The aphia ID invalid')
      end
      @specie_name = @aphia.body[:get_aphia_name_by_id_response][:return]
      if not @specie_name.is_a?(Hash)
        @specie.specie_name = @specie_name
      else
        @specie.aphia_id = nil
      end
    end
    if @specie.save
      redirect_to @specie, flash: {success: "Species was successfully created." }
    else
      render action: 'new' 
    end
  end

  def update
    if params[:specie][:specie_name].present?
      begin
        client = Savon.client(
            :wsdl => "http://www.marinespecies.org/aphia.php?p=soap&wsdl=1",
            :open_timeout => 10,
            :read_timeout => 10,
            :log => false
        )
        @aphia = client.call(:get_aphia_id, message: { scientificname: "#{params[:specie][:specie_name]}" })
      rescue
        @specie_name = "Invalid"
        @specie.errors.add(:base, 'Server not responding')
      end

      # puts "=============================================".blue
      # puts @aphia.body[:get_aphia_id_response][:return]
      # puts "=============================================".blue

      @aphia_id = @aphia.body[:get_aphia_id_response][:return]

      if not @aphia_id.is_a?(Hash)
        params[:specie][:aphia_id] = @aphia_id
      else
        params[:specie][:aphia_id] = nil
      end
    end
    if params[:specie][:aphia_id].present?
      begin
        client = Savon.client(
            :wsdl => "http://www.marinespecies.org/aphia.php?p=soap&wsdl=1",
            :open_timeout => 10,
            :read_timeout => 10,
            :log => false
        )
        @aphia = client.call(:get_aphia_name_by_id, message: { id: "#{params[:specie][:aphia_id]}" })
      rescue
        @aphia = "Invalid"
        @specie.errors.add(:aphia_id, 'The aphia ID invalid')
      end
      @specie_name = @aphia.body[:get_aphia_name_by_id_response][:return]
      if not @specie_name.is_a?(Hash)
        params[:specie][:specie_name] = @specie_name
      else
        params[:specie][:aphia_id] = nil
      end
    end

    if @specie.update(specie_params)
      redirect_to @specie, flash: {success: "Species was successfully updated." }
    else
      render action: 'edit'
    end
  end

  def destroy
    @specie.destroy
    respond_to do |format|
      format.html { redirect_to species_url }
      format.json { head :no_content }
    end
  end

  private

    def get_specie_csv
      csv_string = CSV.generate do |csv|
          csv << ["species_id", "specie_name", "synonym_species", "specie_description"]
          Specie.all.each do |specie|
            syn_vec = []
            specie.synonyms.each do |syn|
              syn_vec << syn.synonym_name
            end
            csv << [specie.id, specie.specie_name, syn_vec.join(", "), specie.specie_description]
          end
        end
     return csv_string
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_specie
      @specie = Specie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def specie_params
      params.require(:specie).permit(:specie_name, :specie_description, :aphia_id, :user_id, :approved, synonyms_attributes: [:id, :synonym_name, :synonym_description, :_destroy])
    end
    
end
