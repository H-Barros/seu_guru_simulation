require "rails_helper"

RSpec.describe "coverages", type: :request do
  before(:all) do
    insurance = Insurance.create!(name: "Insurance Test")
    @coverage = Coverage.create!(insurance_id: insurance.id, name: "Coverage Test", factor: 0.1)
    @new_insurance = Insurance.create!(name: "New Insurance")
    @new_coverage = Coverage.create!(insurance_id: @new_insurance.id, name: "New Coverage", factor: 0.1)
  end

  context "#create" do
    it "Success Response" do
      post "/coverages", params: { coverage: @coverage.attributes }

      expect(response).to be_successful
    end

    it "Record persists" do
      expect {
        post "/coverages", params: { coverage: @coverage.attributes }
      }.to change(Coverage, :count).by(1)
    end
  end

  context "#coverage_by_insurance" do
    it "Success Response" do
      get "/insurance_by_coverage/#{@new_insurance.id}"

      expect(response).to be_successful
    end

    it "Have Correct coverage" do
      get "/insurance_by_coverage/#{@new_insurance.id}"
      response_hash = JSON.parse(response.body)

      expect(response_hash[0]["id"]).to eq(@new_coverage.id)
    end
  end
end