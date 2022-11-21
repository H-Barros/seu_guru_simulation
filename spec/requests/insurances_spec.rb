require "rails_helper"

RSpec.describe "/insurances", type: :request do
  before(:all) do
    @insurance = Insurance.new(name: "Insurance Test")
  end

  context "Register New Insurance" do
    it "Success Response" do
      post "/insurances", params: { insurance: @insurance.attributes }

      expect(response).to be_successful
    end

    it "Record persists" do
      expect {
        post "/insurances", params: { insurance: @insurance.attributes }
      }.to change(Insurance, :count).by(1)
    end
  end
end