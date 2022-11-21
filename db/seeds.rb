insurances = ["seguro de vida","seguro residencial"]
for insurance in insurances do
  Insurance.create!(name: insurance)
end

coverage = { 
  "Morte Acidental": { insurance_id: 1, factor: 0.2 },
  "Invalidez permanente": { insurance_id: 1, factor: 0.9 },
  "Quebra de Vidros": { insurance_id: 2, factor: 0.2 },
  "Vendaval": { insurance_id: 2, factor: 0.1 }
}
coverage.each { |key,value|
  Coverage.create!(insurance_id: value[:insurance_id], name: key, factor: value[:factor])
}
