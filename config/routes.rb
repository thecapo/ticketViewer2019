Rails.application.routes.draw do
  resources :tickets do
    get '/next_page', to: 'tickets#next_page'
  end
	root 'tickets#index'
  match "*path", to: "tickets#catch_404", via: :all
end
