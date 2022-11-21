Rails.application.routes.draw do
  resources :coverages
  resources :insurances

  get "insurance_by_coverage/:insurance_id", to: "coverages#coverage_by_insurance"
  post "simulator", to: "simulators#simulator"
end
