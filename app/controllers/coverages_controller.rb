class CoveragesController < ApplicationController
  before_action :set_coverage, only: %i[ show update destroy ]

  # GET /coverages
  def index
    @coverages = Coverage.all

    render json: @coverages
  end

  # GET /coverages/1
  def show
    render json: @coverage
  end

  # POST /coverages
  def create
    @coverage = Coverage.new(coverage_params)

    if @coverage.save
      render json: @coverage, status: :created, location: @coverage
    else
      render json: @coverage.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /coverages/1
  def update
    if @coverage.update(coverage_params)
      render json: @coverage
    else
      render json: @coverage.errors, status: :unprocessable_entity
    end
  end

  # DELETE /coverages/1
  def destroy
    @coverage.destroy
  end

  def coverage_by_insurance
    render json: Coverage.coverage_by_insurance_id(params[:insurance_id])
  end

  private
    def set_coverage
      @coverage = Coverage.find(params[:id])
    end

    def coverage_params
      params.require(:coverage).permit(:insurance_id, :name, :factor)
    end
end
