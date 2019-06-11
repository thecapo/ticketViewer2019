require 'rails_helper'

RSpec.feature "Tickets", :vcr, type: :feature do
  context 'get tickets' do

    before (:each) do
      visit root_path
    end

    scenario 'should show tickets if successful' do
      expect(page).to have_content()
      expect(page).to have_content('Tickets')
      expect(page).to have_content('Subject')
      expect(page).to have_css('.pagination')
      expect(page).to have_css('.current')
    end

    scenario 'no tickets to show' do
      expect(page).to have_content('Oooops, No Tickets Found')
    end

    scenario 'there are at 25 tickets in a page' do
      within('table') do
        expect(page).to have_xpath(".//tr/./td[@class='ticketID']", count: 25)
      end
    end
    
  end
  
  context 'show individual ticket' do

    scenario 'should show an individual ticket if it exist' do
      visit root_path
      page.find('.oneTicket', match: :first).click_link
      expect(page).to have_content('Ticket Viewer')
      expect(page).to have_content('Ticket ID')
      expect(page).to have_content('Subject')
      expect(page).to have_content('Description')
      expect(page).to have_link 'Back', href: tickets_path
      expect(page.status_code == 200)
    end

    scenario 'invalid ticket id' do
      visit "/tickets/100A0" 
      expect(page.status_code == 404)
    end

    # adding factory_girl to simplify the api

    # context 'pagination when tickets are loaded' do
    #   scenario 'initial pagination loading' do
    #     visit root_path
    #     # previous disabled
    #     expect(page).to 
    #   end

    #   scenario 'last page of pagination' do
    #     # next should be disabled
    #   end

    #   scenario 'within pagination' do
    #   end
    
    #   scenario 'over pagination page' do
    #   end
    # end

  end
end
