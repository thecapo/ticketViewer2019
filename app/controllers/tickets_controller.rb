class TicketsController < ApplicationController
  require 'will_paginate/array'
		  
  def index
    # move the url so it can be reused
    # add attr
    # initialize
    # if response is not valid
    response = HTTParty.get('https://the7thcapo18.zendesk.com/api/v2/tickets.json', basic_auth: set_ticket, :headers => {'Content-Type' => 'application/json'} )
    @ticketsParsed = response.parsed_response["tickets"]
    @tickets = @ticketsParsed.paginate(:page => params[:page], :per_page => 25)
    # if (@tickets.count <= 25)
    #   @tickets = @ticketsParsed.paginate(:page => params[:page], :per_page => 25)
    # else
    #   @ticketsParsed = response.parsed_response["tickets"].nextpage
    
    # chols
  end

  def show
    # move the url so it can be reused
    @urlTicket = "https://the7thcapo18.zendesk.com/api/v2/tickets/#{(params[:id])}" 
    @response = HTTParty.get(@urlTicket, basic_auth: set_ticket, :headers => {'Content-Type' => 'application/json'} )
    @showTicket = @response.parsed_response["ticket"]

  if @showTicket.nil?
    render file: "#{Rails.root}/public/404.html" , status: :not_found  
  else
    @showTicket
  end 

  end 

  def catch_404
    raise ActionController::RoutingError.new(params[:path]) 
  end

  def not_found
    raise ActionController::RoutingError.new(params[:path]) 
  end

  def catch_422
    raise ActionController::UnknownFormat.new(params[:path]) 
  end

  private

  def set_ticket
    auth = {username: "the7thcapo@gmail.com", password: "DesktopZEN1"}
  end
end
