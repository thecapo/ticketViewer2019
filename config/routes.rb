Rails.application.routes.draw do
  resources :tickets
	root 'tickets#index'
  match "*path", to: "tickets#catch_404", via: :all
end
