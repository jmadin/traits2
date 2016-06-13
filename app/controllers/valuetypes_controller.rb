class ValuetypesController < ApplicationController
  before_action :editor
  before_action :set_valuetype, only: [:show, :edit, :update, :destroy]

  def index
    @valuetypes = Valuetype.all

    respond_to do |format|
      format.html
      format.csv { send_data Valuetype.all.to_csv }      
    end    
  end

  def new
    @valuetype = Valuetype.new
  end

  def edit
  end

  def create
    @valuetype = Valuetype.new(valuetype_params)

    if @valuetype.save
      redirect_to valuetypes_path, flash: {success: "Value type was successfully created." }
    else
      render action: 'new' 
    end
  end

  def update
    if @valuetype.update(valuetype_params)
      redirect_to valuetypes_path, flash: {success: "Value type was successfully updated." }
    else
      render action: 'edit'
    end
  end

  def destroy
    if @valuetype.destroy
      redirect_to valuetypes_url, flash: {success: "Value type was successfully deleted."}
    else
      redirect_to valuetypes_url, flash: {danger: "Value type is in use and can't be deleted."}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_valuetype
      @valuetype = Valuetype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def valuetype_params
      params.require(:valuetype).permit(:user_id, :value_type_name, :value_type_description, :has_precision)
    end
end
