json.array!(@lits) do |lit|
  json.extract! lit, :id, :name, :personne_id, :chambre_id
  json.url lit_url(lit, format: :json)
end
