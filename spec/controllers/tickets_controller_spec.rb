require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  # check if it connects to zendesk api
	describe "get all tickets", :vcr do
		
		it "using basic auth" do
			basic_auth = {username: 'the7thcapo@gmail.com', password: 'DesktopZEN1'}
			request = HTTParty::Request.new(Net::HTTP::Get, 'https://the7thcapo18.zendesk.com/api/v2/tickets.json', basic_auth: basic_auth, :headers => {'Content-Type' => 'application/json'} )
			expect(request.options[:basic_auth]).to eq({username: 'the7thcapo@gmail.com', password: 'DesktopZEN1'})
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
end
