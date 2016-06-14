class MethodologiesController < ApplicationController
  before_action :contributor, except: [:index, :show, :export]
  before_action :set_methodology, only: [:show, :edit, :update, :destroy, :remove_trait]
  before_action :admin_user, only: :destroy

  def new
  	@methodology = Methodology.new
  end

  def create
  	@methodology = Methodology.new(methodology_params)
  	
  	if @methodology.save
      redirect_to methodologies_path, flash: {success: "Methodology was successfully created." }
    else
      render action: 'new' 
    end
  end

  def index
    @search = Methodology.search do
      fulltext params[:search]
      order_by :methodology_name_sortable, :asc
      
      if params[:all]
        paginate page: params[:page], per_page: 9999
      else
        paginate page: params[:page]
      end
    end
    @methodologies = @search.results

  	respond_to do |format|
      format.html
      format.csv { send_data Methodology.all.to_csv }
    end    
  end

  def show
    @observations = Observation.where(:id => @methodology.measurements.map(&:observation_id))
    @observations = observation_filter(@observations)

    @traits = Trait.where(:id => Measurement.where("observation_id IN (?) AND methodology_id = ?", @observations.map(&:id), @methodology.id).map(&:trait_id))

    respond_to do |format|
      format.html { @observations = @observations.paginate(page: params[:page]) }
      format.csv { download_observations(@observations) }
      format.zip{ send_zip(@observations) }
    end
  end

  def edit
  end

  def update
    if @methodology.update(methodology_params)
      redirect_to @methodology, flash: {success: "Methodology was successfully updated." }
    else
      render action: 'edit'
    end
  end

  def destroy
    @methodology.destroy
    respond_to do |format|
      format.html { redirect_to methodologies_path }
      format.json { head :no_content }
    end
  end

  def export
    @observations = Observation.where(:id => Measurement.where("methodology_id IN (?)", params[:checked]).map(&:observation_id))
    @observations = observation_filter(@observations)
    if params[:checked] and @observations.present?
      send_zip(@observations)                   
    else
      redirect_to methodologies_url, flash: {danger: "Nothing to download." }
    end
  end

  private
  	def set_methodology
      @methodology = Methodology.find(params[:id])
    end
  	
  	def methodology_params
  		params.require(:methodology).permit(:methodology_name, :user_id, :methodology_description, :approved, :traits_attributes)
  	end
end