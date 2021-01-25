class RentsController < ApplicationController
  before_action :set_rent, only: [:show, :edit, :update, :destroy]

  # GET /rents
  # GET /rents.json
  def index
    @rents = Rent.all
  end

  # GET /rents/1
  # GET /rents/1.json
  def show
  end

  # GET /rents/new
  def new
    @rent = Rent.new
    2.times { @rent.stations.build }
  end

  # GET /rents/1/edit
  def edit
    stations = Station.where(rent_id: @rent.id)
    flg = 0
    for station in stations do
      if !(station.line == "" && station.name == "" && !station.time)
        flg += 1
      end
    end
    if stations.length == flg
      @rent.stations.build
    end
  end

  # POST /rents
  # POST /rents.json
  def create
    @rent = Rent.new(rent_params)

    respond_to do |format|
      if @rent.save
        format.html { redirect_to @rent, notice: '物件情報を登録しました！' }
        format.json { render :show, status: :created, location: @rent }
      else
        format.html { render :new }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rents/1
  # PATCH/PUT /rents/1.json
  def update
    respond_to do |format|
      if @rent.update(rent_params)
        format.html { redirect_to @rent, notice: '物件情報を編集しました！' }
        format.json { render :show, status: :ok, location: @rent }
      else
        format.html { render :edit }
        format.json { render json: @rent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rents/1
  # DELETE /rents/1.json
  def destroy
    @rent.destroy
    respond_to do |format|
      format.html { redirect_to rents_url, notice: '物件情報を削除しました！' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_rent
    @rent = Rent.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rent_params
    params.require(:rent).permit(
      :name,
      :price,
      :address,
      :age,
      :other,
      stations_attributes: [
        :id,
        :line,
        :name,
        :time,
        :rent_id]
    )
  end
end
