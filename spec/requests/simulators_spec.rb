require "rails_helper"

RSpec.describe "/simulator", type: :request do
  it "Success Response" do
    params = {
      isurance_id: 2,
      coverages: [
        {
          coverage_id: 3,
          capital: 1000
        },
        {
          coverage_id: 4,
          capital: 1000
        }
      ]
    }

    post "/simulator", params: params
    
    expect(response).to be_successful
  end

  it "Not found coverages in body" do
    params = {
      isurance_id: 2
    }

    post "/simulator", params: params
    
    expect(response.body.include?("coverages")).to be(true)
  end

  it "Not found insurance_id in body" do
    params = {
      coverages: [
        {
          coverage_id: 3,
          capital: 1000
        },
        {
          coverage_id: 4,
          capital: 1000
        }
      ]
    }

    post "/simulator", params: params
    
    expect(response.body.include?("insurance_id")).to be(true)
  end
end