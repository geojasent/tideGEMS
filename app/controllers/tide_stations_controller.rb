class TideStationsController < ApplicationController
  before_action :set_tide_station, only: %i[ show edit update destroy ]

  # GET /tide_stations or /tide_stations.json
  def index
    @tide_stations = TideStation.all
  end

  # GET /tide_stations/1 or /tide_stations/1.json
  def show
  end

  # GET /tide_stations/new
  def new
    @tide_station = TideStation.new
  end

  # GET /tide_stations/1/edit
  def edit
  end

  # POST /tide_stations or /tide_stations.json
  def create
    @tide_station = TideStation.new(tide_station_params)

    respond_to do |format|
      if @tide_station.save
        format.html { redirect_to tide_station_url(@tide_station), notice: "Tide station was successfully created." }
        format.json { render :show, status: :created, location: @tide_station }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tide_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tide_stations/1 or /tide_stations/1.json
  def update
    respond_to do |format|
      if @tide_station.update(tide_station_params)
        format.html { redirect_to tide_station_url(@tide_station), notice: "Tide station was successfully updated." }
        format.json { render :show, status: :ok, location: @tide_station }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tide_station.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tide_stations/1 or /tide_stations/1.json
  def destroy
    @tide_station.destroy

    respond_to do |format|
      format.html { redirect_to tide_stations_url, notice: "Tide station was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tide_station
      @tide_station = TideStation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tide_station_params
      params.require(:tide_station).permit(:station_name, :station_number, :latitude, :longitude)
    end
end
