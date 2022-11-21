require 'rails_helper'

RSpec.describe Insurance, type: :model do
  context "validates" do
    it "name can't be blank" do
      coverage = Coverage.new(insurance_id: 1, factor: 0.5)

      expect(coverage).not_to be_valid
    end
  end
end
