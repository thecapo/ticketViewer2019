require 'rails_helper'

RSpec.feature "Tickets", :vcr, type: :feature do
  context 'tickets' do

    before (:each) do
      visit root_path
    end

    scenario 'will show if successful' do
      expect(page).to have_content()
      expect(page).to have_content('Tickets')
      expect(page).to have_content('Subject')
      expect(page).to have_css('.pagination')
      expect(page).to have_css('.current')
    end

    scenario 'nothing to show' do
      if page.current_path.empty?
        expect(page).to have_content('Oooops, No Tickets Found')
      end
    end

    scenario 'there are at 25 tickets in a page' do
      within('table') do
        expect(page).to have_xpath(".//tr/./td[@class='ticketID']", count: 25)
      end
    end
    
  end
  
  context 'individual ticket' do

    scenario 'if it exist' do
      visit root_path
      page.find('.oneTicket', match: :first).click_link
      expect(page).to have_content('Ticket Viewer')
      expect(page).to have_content('Ticket ID')
      expect(page).to have_content('Subject')
      expect(page).to have_content('Description')
      expect(page).to have_link 'Back'
      expect(page.status_code == 200)
    end

    scenario 'with invalid ticket id' do
      visit "/tickets/100A0" 
      expect(page.status_code == 404)
      page.find('h1', text: 'The page you were looking for doesn\'t exist.')
    end

  end

  context 'pagination when tickets are loaded' do

    scenario 'if the endpoints have tickets' do
      visit '/tickets/2/next_page'
      expect(page).to have_content()
    end

    scenario 'if no tickets on the endpoint' do
      visit '/tickets/60/next_page'
      expect(page).to have_content('Oooops, No Tickets Found') 
    end

    scenario 'if invalid endpoint' do
      visit '/tickets/qeqwee/next_page'
      expect(page.status_code == 404)
      page.find('h1', text: 'The page you were looking for doesn\'t exist.')
    end

  end
end
