module Integration 
  def credentials_for(user)
    Authentication.create_credentials user
  end
end