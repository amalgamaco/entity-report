Rails.application.routes.draw do
	use_doorkeeper :scope => 'v1/oauth' do
		skip_controllers :authorizations, :applications, :authorized_applications
	end

	devise_for :users, skip: [:confirmations, :registrations, :unlocks]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
