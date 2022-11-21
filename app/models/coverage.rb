class Coverage < ApplicationRecord
  belongs_to :insurance

  validates :name, presence: true

  def self.coverage_by_insurance_id(insurance_id)
    Coverage.where(insurance: insurance_id)
  end
end
