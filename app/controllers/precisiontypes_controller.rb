class PrecisiontypesController < ApplicationController
  before_action :editor
  before_action :set_precisiontype, only: [:show, :edit, :update, :destroy]

  def index
    @precisiontypes = Precisiontype.all
  end

  def new
    @precisiontype = Precisiontype.new
  end

  def edit
  end

  def create
    @precisiontype = Precisiontype.new(precisiontype_params)

    if @precisiontype.save
      redirect_to precisiontypes_path, flash: {success: "Precision type was successfully created." }
    else
      render action: 'new' 
    end
  end

  def update
    if @precisiontype.update(precisiontype_params)
      redirect_to precisiontypes_path, flash: {success: "Precision type was successfully updated." }
    else
      render action: 'edit'
    end
  end

  def destroy
    if @precisiontype.destroy
      redirect_to precisiontypes_url, flash: {success: "Precision type was successfully deleted."}
    else
      redirect_to precisiontypes_url, flash: {danger: "Precision type is in use and can't be deleted."}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_precisiontype
      @precisiontype = Precisiontype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def precisiontype_params
      params.require(:precisiontype).permit(:user_id, :precision_type_name, :precision_type_description, :has_range)
    end
end
