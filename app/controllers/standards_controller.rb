class StandardsController < ApplicationController
  before_action :contributor, except: [:index, :show, :export]
  before_action :set_standard, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: :destroy

  def index
    @search = Standard.search do
      fulltext params[:search]
      order_by :standard_class_sortable, :asc
      order_by :standard_name_sortable, :asc

      if params[:all]
        paginate page: params[:page], per_page: 9999
      else
        paginate page: params[:page]
      end
    end
    @standards = @search.results

    respond_to do |format|
      format.html
      format.csv { send_data Standard.all.to_csv }      
    end    

  end

  def show
    @observations = Observation.joins(:measurements).where('measurements.standard_id = ?', @standard.id)
    @observations = observation_filter(@observations)

    respond_to do |format|
      format.html { @observations = @observations.paginate(page: params[:page]) }
      format.csv { download_observations(@observations) }
      format.zip { send_zip(@observations) }
    end
  end

  def export
    if params[:checked]
      @observations = Observation.joins(:measurements).where(:measurements => {:standard_id => params[:checked]})
      send_zip(@observations)          
    else
      redirect_to standards_url, flash: {danger: "Nothing selected." }
    end
  end

  def new
    @standard = Standard.new
  end

  def edit
  end

  def create
    @standard = Standard.new(standard_params)

    if @standard.save
      redirect_to @standard, flash: {success: "Standard was successfully created." }
    else
      render action: 'new' 
    end
  end

  def update
    if @standard.update(standard_params)
      redirect_to @standard, flash: {success: "Standard was successfully updated." }
    else
      render action: 'edit'
    end
  end

  def destroy
    @standard.destroy
    respond_to do |format|
      format.html { redirect_to standards_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_standard
      @standard = Standard.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def standard_params
      params.require(:standard).permit(:standard_name, :standard_unit, :standard_class, :standard_description, :user_id, :approved)
    end
end
