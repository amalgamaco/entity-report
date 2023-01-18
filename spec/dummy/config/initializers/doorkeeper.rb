# config/initializers/doorkeeper.rb

Doorkeeper.configure do
  # Change the ORM that doorkeeper will use (needs plugins)
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_from_credentials do
    User.find_by({username: params[:username]}) || redirect_to(new_user_session_url)
  end

  grant_flows %w[password]
  skip_authorization do
	  true
  end
end
