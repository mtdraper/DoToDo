json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :username, :email, :crypted_password, :password_salt, :persistence_token, :single_access_token
  json.url user_url(user, format: :json)
end
