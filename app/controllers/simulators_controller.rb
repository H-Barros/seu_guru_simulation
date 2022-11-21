class SimulatorsController < ApplicationController
  def simulator
    render json: Simulator.simulation(params)
  end
end
