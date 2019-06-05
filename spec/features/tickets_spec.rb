require 'rails_helper'

RSpec.feature "Tickets", :vcr, type: :feature do
  context 'get tickets' do
    scenario 'should show tickets if successful' do
      visit root_path
      expect(page).to have_content()
      expect(page).to have_content('Tickets')
      expect(page).to have_content('Subject')
      expect(page).to have_css('.pagination')
      expect(page).to have_css('.current')
      # expect(page).to have_css('.previous_page')
      # expect(page).to have_selector(:css, 'a[href="/tickets?page=2"]')
      # expect(page).has_link('a[href]')
    end

    scenario 'no tickets to show' do
      
    end

    # scenario 'should not show tickets if api is down' do
    #   visit root_path
    #   expect(response).to have_http_status(200)
    # end
  end

  context 'show individual ticket' do
    scenario 'should show an individual ticket if it exist' do
      visit root_path
      expect(page).to have_content('Subject')
      # find("a[href='/tickets/1']").click_link('Show')  
      
    # expect(page).to have_content 'Featured News Article'
    # expect(page).to_not have_content "No Featured Companies"
    # expect(page).to_not have_content 'Edit Featured Company'
      # expect(page).has_css?('#ticketID')
    end
    scenario 'ticket does not exist' do
    end
  end
end
