Rails.application.routes.draw do
  resources :tickets, only: [:index, :show] do
    get '/next_page', to: 'tickets#index'
  end
	root 'tickets#index'
  match "*path", to: "tickets#catch_404", via: :all
end
