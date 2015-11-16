json.array!(@typeresids) do |typeresid|
  json.extract! typeresid, :id
  json.url typeresid_url(typeresid, format: :json)
end
