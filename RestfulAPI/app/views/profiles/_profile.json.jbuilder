json.extract! profile, :id, :firstname, :lastname, :company, :created_at, :updated_at
json.url profile_url(profile, format: :json)
