class Simulator < ApplicationRecord
  def self.simulation(params)
    return { error: "Was not found coverages in body" } if params[:coverages].nil?
    return { error: "Was not found insurance_id in body" } if params[:insurance_id].nil?
    return { error: "Has invalid coverages for this insurance" } unless valid_coverage_id_by_secure_id?(params[:insurance_id],params[:coverages])

    coverage_results = params[:coverages].map { |coverage|
      current_coverage = Coverage.find(coverage[:coverage_id])

      {
        coverage_id: coverage[:coverage_id],
        name: current_coverage.name,
        capital: coverage[:capital],
        premium: calculate_premium(coverage[:capital],current_coverage.factor)
      }
    }

    { 
      insurance_id: params[:insurance_id],
      coverages: coverage_results,
      total: calculate_total(coverage_results)
    }
  end

  private_class_method def self.calculate_premium(capital,factor)
    capital * factor
  end

  private_class_method def self.calculate_total(coverage_with_premium)
    total = 0
    
    coverage_with_premium.each { |coverage|
      total += coverage[:premium]
    }
    
    total
  end

  private_class_method def self.valid_coverage_id_by_secure_id?(insurance_id,coverages)
    is_valid_coverages = true

    coverages_by_insurance_id = Coverage.coverage_by_insurance_id(insurance_id)
    valid_coverages_id = coverages_by_insurance_id.map { |coverage| 
      coverage[:id]
    }

    coverages.each { |coverage|
      is_valid_coverages = false unless valid_coverages_id.include?(coverage[:coverage_id])
    }

    is_valid_coverages
  end
end
