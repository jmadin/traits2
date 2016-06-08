class TraitclassesController < ApplicationController
  before_action :editor
  before_action :set_traitclass, only: [:edit, :update, :destroy]
  # before_action :contributor, except: [:index, :show, :export]
  before_action :admin_user, only: :destroy

  def index
    @traitclasses = Traitclass.all
  end

  def new
    @traitclass = Traitclass.new
  end

  def edit
  end

  def create
    @traitclass = Traitclass.new(traitclass_params)

    if @traitclass.save
      redirect_to traitclasses_path, flash: {success: "Class was successfully created." }
    else
      render action: 'new' 
    end
  end

  def update
    if @traitclass.update(traitclass_params)
      redirect_to traitclasses_path, flash: {success: "Class was successfully updated." }
    else
      render action: 'edit'
    end
  end

  def destroy
    if @traitclass.destroy
      redirect_to traitclasses_url, flash: {success: "Class was successfully deleted."}
    else
      redirect_to traitclasses_url, flash: {danger: "Class is in use and can't be deleted."}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_traitclass
      @traitclass = Traitclass.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def traitclass_params
      params.require(:traitclass).permit(:user_id, :class_name, :class_notes, :contextual)
    end
end
