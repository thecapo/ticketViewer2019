class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActionController::RoutingError do |exception|
		logger.error 'Routing error occured' 
		render file: "#{Rails.root}/public/404.html" , status: :not_found  
	end

	rescue_from ActionController::UnknownFormat do |exception|
		logger.error 'Unknown Format'
		render file: "#{Rails.root}/public/422.html" , status: :not_found  
	end
end
