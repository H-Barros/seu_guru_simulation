require 'rails_helper'

RSpec.describe Simulator, type: :model do
  context "#simulation" do
    before(:all) do
      @first_insurance = Insurance.create!(name: "Insurance 1")
      @second_insurance = Insurance.create!(name: "Insurance 2")
      @first_coverage = Coverage.create!(insurance_id: @first_insurance.id, name: "Coverage 1", factor: 0.1)
      @second_coverage = Coverage.create!(insurance_id: @second_insurance.id, name: "Coverage 2", factor: 0.2)
      @third_coverage = Coverage.create!(insurance_id: @second_insurance.id, name: "Coverage 3", factor: 0.1)
    end

    it "Coverange with different insurance of request" do
      params = {
        insurance_id: @first_insurance.id,
        coverages: [
          {
            coverage_id: @second_coverage.id,
            capital: 1000
          }
        ]
      }

      simulation = Simulator.simulation(params)

      expect(simulation.key?(:error)).to eq(true)
    end

    it "Coverage with same insurance of request" do
      params = {
        insurance_id: @first_insurance.id,
        coverages: [
          {
            coverage_id: @first_coverage.id,
            capital: 1000
          }
        ]
      }
      
      simulation = Simulator.simulation(params)

      expect(simulation.key?(:error)).to eq(false)
    end

    it "Correct premium value" do
      params = {
        insurance_id: @first_insurance.id,
        coverages: [
          {
            coverage_id: @first_coverage.id,
            capital: 1000
          }
        ]
      }

      simulation = Simulator.simulation(params)

      expect(simulation[:coverages][0][:premium]).to eq(params[:coverages][0][:capital] * @first_coverage.factor)
    end

    it "Correct total value" do
      total_value = 0
      params = {
        insurance_id: @second_insurance.id,
        coverages: [
          {
            coverage_id: @second_coverage.id,
            capital: 1000
          },
          {
            coverage_id: @third_coverage.id,
            capital: 1000
          }
        ]
      }

      simulation = Simulator.simulation(params)
      simulation[:coverages].each { |coverage|
        total_value += coverage[:premium]
      }

      expect(simulation[:total]).to eq(total_value)
    end
  end
end
