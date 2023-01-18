Rails.application.routes.draw do
	use_doorkeeper :scope => 'v1/oauth' do
		skip_controllers :authorizations, :applications, :authorized_applications
	end

	use_doorkeeper

	devise_for :users, skip: [:confirmations, :registrations, :unlocks]

	resources :reports, only: [:create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
