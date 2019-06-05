require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  #  add capybara for user interactions
  #  factory girl?

  # check if it connects to zendesk api
  # username or password invalid?
  describe "get all tickets", :vcr do
		before do
			@urlTicket = "https://the7thcapo18.zendesk.com/api/v2/tickets/"
    	@auth = {username: "the7thcapo@gmail.com", password: "DesktopZEN1"}	
		end

		it 'returns a status message' do
			get :index
			expect(response.status).to eql(200)
		end

		it "lists the tickets" do
			get :index
			expect(response).to be_success
		end

		it "should respond to parsed_response" do
			response = HTTParty.get(@urlTicket, basic_auth: @auth, :headers => {'Content-Type' => 'application/json'} )
			expect(response.respond_to?(:parsed_response)).to be_truthy
		end
	end
	# it "should tell that a ticket does not exist" do
	# 	response = HTTParty.get(@urlTicket, basic_auth: @auth, :headers => {'Content-Type' => 'application/json'} )
	# 	@showTicket = response.parsed_response["ticket"]
	# 	expect(@showTicket).to be_nil
	# end
	# it "should tell a ticket exist" do
	# 	response = HTTParty.get("https://the7thcapo18.zendesk.com/api/v2/tickets/1", basic_auth: @auth, :headers => {'Content-Type' => 'application/json'} )
	# 	@showTicket = response.parsed_response["ticket"]
	# 	expect(@showTicket).to be_truthy
	# end
	# request the tickets for your account, page through tickets when more than 25 are returned
	
  # Display them in a list
  # Display individual ticket details
  # The ticket viewer should handle the API being unavailable
  # Handles friendly error message if the API is unavailable or the response is invalid
  # tells the user something is wrong if there is a program error
end
