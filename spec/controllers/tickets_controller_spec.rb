require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  # check if it connects to zendesk api
	describe "get all tickets", :vcr do
		
		it "using basic auth" do
			basic_auth = {username: 'the7thcapo@gmail.com', password: 'DesktopZEN1'}
			request = HTTParty::Request.new(Net::HTTP::Get, 'https://the7thcapo18.zendesk.com/api/v2/tickets.json', basic_auth: basic_auth, :headers => {'Content-Type' => 'application/json'} )
			expect(request.options[:basic_auth]).to eq({username: 'the7thcapo@gmail.com', password: 'DesktopZEN1'})
		end

	end
	
	describe "HTTParty formatting" do
		
    context "request are to be made" do
      it "returns the json format" do
        request = HTTParty::Request.new 'get', 'https://the7thcapo18.zendesk.com/api/v2/tickets.json', format: :json
        expect(request.format).to eq(:json)
			end

			it "returns nil format" do
        request = HTTParty::Request.new 'get', 'https://the7thcapo18.zendesk.com/api/v2/tickets.json'
        expect(request.format).to be_nil
      end
		end
		
	end
			
	# request the tickets for your account, page through tickets when more than 25 are returned
	
  # Display them in a list
  # Display individual ticket details
  # The ticket viewer should handle the API being unavailable
  # Handles friendly error message if the API is unavailable or the response is invalid
	# tells the user something is wrong if there is a program error
	# end
end
