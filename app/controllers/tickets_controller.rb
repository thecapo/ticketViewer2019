class TicketsController < ApplicationController
  require 'will_paginate/array'

  before_action :api_connect, only: [:index, :next_page]
  before_action :one_ticket, only: [:show]
  
  def show
    if @showTicket.nil?
      render file: "#{Rails.root}/public/404.html" , status: :not_found  
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

  def api_connect
    # gets all tickets
    response = HTTParty.get("https://the7thcapo18.zendesk.com/api/v2/tickets?page=#{(params[:ticket_id])}", basic_auth: set_ticket, :headers => {'Content-Type' => 'application/json'} ) 
    @ticketsParsed = response.parsed_response["tickets"]
    @tickets = @ticketsParsed.paginate(:page => params[:page], :per_page => 25)
  end

  def one_ticket
    # gets the specific ticket
    @urlTicket = "https://the7thcapo18.zendesk.com/api/v2/tickets/#{(params[:id])}" 
    @response = HTTParty.get(@urlTicket, basic_auth: set_ticket, :headers => {'Content-Type' => 'application/json'} )
    @showTicket = @response.parsed_response["ticket"]
  end

  def set_ticket
    auth = {username: "the7thcapo@gmail.com", password: "DesktopZEN1"}
  end
end
