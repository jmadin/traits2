# class MeasurementsMethodologiesController < ApplicationController
#   before_action :set_measurements_methodology, only: [:show, :edit, :update, :destroy]

#   # GET /measurements_methodologies
#   # GET /measurements_methodologies.json
#   def index
#     @measurements_methodologies = MeasurementsMethodology.all
#   end

#   # GET /measurements_methodologies/1
#   # GET /measurements_methodologies/1.json
#   def show
#   end

#   # GET /measurements_methodologies/new
#   def new
#     @measurements_methodology = MeasurementsMethodology.new
#   end

#   # GET /measurements_methodologies/1/edit
#   def edit
#   end

#   # POST /measurements_methodologies
#   # POST /measurements_methodologies.json
#   def create
#     @measurements_methodology = MeasurementsMethodology.new(measurements_methodology_params)

#     respond_to do |format|
#       if @measurements_methodology.save
#         format.html { redirect_to @measurements_methodology, notice: 'Measurements methodology was successfully created.' }
#         format.json { render :show, status: :created, location: @measurements_methodology }
#       else
#         format.html { render :new }
#         format.json { render json: @measurements_methodology.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # PATCH/PUT /measurements_methodologies/1
#   # PATCH/PUT /measurements_methodologies/1.json
#   def update
#     respond_to do |format|
#       if @measurements_methodology.update(measurements_methodology_params)
#         format.html { redirect_to @measurements_methodology, notice: 'Measurements methodology was successfully updated.' }
#         format.json { render :show, status: :ok, location: @measurements_methodology }
#       else
#         format.html { render :edit }
#         format.json { render json: @measurements_methodology.errors, status: :unprocessable_entity }
#       end
#     end
#   end

#   # DELETE /measurements_methodologies/1
#   # DELETE /measurements_methodologies/1.json
#   def destroy
#     @measurements_methodology.destroy
#     respond_to do |format|
#       format.html { redirect_to measurements_methodologies_url, notice: 'Measurements methodology was successfully destroyed.' }
#       format.json { head :no_content }
#     end
#   end

#   private
#     # Use callbacks to share common setup or constraints between actions.
#     def set_measurements_methodology
#       @measurements_methodology = MeasurementsMethodology.find(params[:id])
#     end

#     # Never trust parameters from the scary internet, only allow the white list through.
#     def measurements_methodology_params
#       params.require(:measurements_methodology).permit(:measurement_id, :methodology_id)
#     end
# end
