json.array!(@preregistrations) do |preregistration|
  json.extract! preregistration, :id
  json.url preregistration_url(preregistration, format: :json)
end
