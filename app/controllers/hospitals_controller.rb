class HospitalsController < ApplicationController
  before_action :set_hospital, only: [:show, :edit, :update, :destroy]

  # GET /hospitals
  # GET /hospitals.json
  def index
    @hospitals = Hospital.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /hospitals/1
  # GET /hospitals/1.json
  def show
    hospital_id = params[:id]
    @divisions = Division.joins(:div_hosp_doc_ships).where("div_hosp_doc_ships.hospital_id = #{hospital_id} and div_hosp_doc_ships.doctor_id is not null").uniq{|x| x.id}
    if @divisions.size == 0
      @divisions = Division.joins(:div_hosp_doc_ships).where("div_hosp_doc_ships.hospital_id = #{hospital_id}").uniq{|x| x.id}
    end
  end

  # GET /hospitals/new
  def new
    @hospital = Hospital.new
  end

  # GET /hospitals/1/edit
  def edit
  end

  # POST /hospitals
  # POST /hospitals.json
  def create
    @hospital = Hospital.new(hospital_params)

    respond_to do |format|
      if @hospital.save
        format.html { redirect_to @hospital, notice: 'Hospital was successfully created.' }
        format.json { render :show, status: :created, location: @hospital }
      else
        format.html { render :new }
        format.json { render json: @hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hospitals/1
  # PATCH/PUT /hospitals/1.json
  def update
    respond_to do |format|
      hospital_attr = hospital_params
      hospital_attr["cHours"] = eval(params[:hospital][:cHours])
      if @hospital.update(hospital_attr)
        format.html { redirect_to @hospital, notice: 'Hospital was successfully updated.' }
        format.json { render :show, status: :ok, location: @hospital }
      else
        format.html { render :edit }
        format.json { render json: @hospital.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hospitals/1
  # DELETE /hospitals/1.json
  def destroy
    @hospital.destroy
    respond_to do |format|
      format.html { redirect_to hospitals_url, notice: 'Hospital was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hospital
      @hospital = Hospital.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hospital_params
      params.require(:hospital).permit(:name,:phone,:address,:grade,:assess,:on,:ss)
    end
end
