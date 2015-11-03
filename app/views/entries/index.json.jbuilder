json.array!(@entries) do |e|
  json.extract! e,
  json.url entry_url(e, format: :json)
end
