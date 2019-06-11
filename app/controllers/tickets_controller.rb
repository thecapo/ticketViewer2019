class TicketsController < ApplicationController
  require 'will_paginate/array'
  
  def index
    # gets all tickets
    response = HTTParty.get("https://the7thcapo18.zendesk.com/api/v2/tickets?page=#{(params[:ticket_id])}", basic_auth: set_ticket, :headers => {'Content-Type' => 'application/json'} ) 
    if @ticketsParsed = response.parsed_response["tickets"]
      @tickets = @ticketsParsed.paginate(:page => params[:page], :per_page => 25)
    else
      render file: "#{Rails.root}/public/404.html" , status: :not_found  
    end
  end

  def show
    # gets the specific ticket
    @urlTicket = "https://the7thcapo18.zendesk.com/api/v2/tickets/#{(params[:id])}" 
    @response = HTTParty.get(@urlTicket, basic_auth: set_ticket, :headers => {'Content-Type' => 'application/json'} )
    @showTicket = @response.parsed_response["ticket"]
    if @showTicket.nil?
      render file: "#{Rails.root}/public/404.html" , status: :not_found  
    end 
  end 

  private

  def set_ticket
    auth = {username: "the7thcapo@gmail.com", password: "DesktopZEN1"}
  end
end
