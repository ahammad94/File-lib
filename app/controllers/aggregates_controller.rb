class AggregatesController < ApplicationController
  before_action :set_aggregate, only: [:show, :edit, :update, :destroy]

  # GET /aggregates
  # GET /aggregates.json
  def index
    @aggregates = Aggregate.all
  end

  # GET /aggregates/1
  # GET /aggregates/1.json
  def show
  end

  def search
  end

  # GET /aggregates/new
  def new
    @aggregate = Aggregate.new
  end

  # GET /aggregates/1/edit
  def edit
  end

  # POST /aggregates
  # POST /aggregates.json
  def create
    @aggregate = Aggregate.new(aggregate_params)

    respond_to do |format|
      if @aggregate.save
        format.html { redirect_to @aggregate, notice: 'Aggregate was successfully created.' }
        format.json { render :show, status: :created, location: @aggregate }
      else
        format.html { render :new }
        format.json { render json: @aggregate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aggregates/1
  # PATCH/PUT /aggregates/1.json
  def update
    respond_to do |format|
      if @aggregate.update(aggregate_params)
        format.html { redirect_to @aggregate, notice: 'Aggregate was successfully updated.' }
        format.json { render :show, status: :ok, location: @aggregate }
      else
        format.html { render :edit }
        format.json { render json: @aggregate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aggregates/1
  # DELETE /aggregates/1.json
  def destroy
    @aggregate.destroy
    respond_to do |format|
      format.html { redirect_to aggregates_url, notice: 'Aggregate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aggregate
      @aggregate = Aggregate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aggregate_params
      params.require(:aggregate).permit(:file_name, :file_type)
    end
end
