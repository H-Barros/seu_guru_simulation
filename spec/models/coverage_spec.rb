require 'rails_helper'

RSpec.describe Coverage, type: :model do
  context "validates" do
    it "name can't be blank" do
      coverage = Coverage.new(insurance_id: 1, factor: 0.5)

      expect(coverage).not_to be_valid
    end
  end

  it "return coverages by insurance_id" do
    first_insurance = Insurance.create!(name: "Insurance 1")
    second_insurance = Insurance.create!(name: "Insurance 2")
    first_coverage = Coverage.create!(insurance_id: first_insurance.id, name: "Coverage 1", factor: 0.1)
    second_coverage = Coverage.create!(insurance_id: second_insurance.id, name: "Coverage 2", factor: 0.2)

    coverage_test = Coverage.coverage_by_insurance_id(first_insurance.id)

    expect(coverage_test[0].id).to eq(first_coverage.id)
  end
end
