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
    end

    scenario 'no tickets to show' do
      visit root_path
      expect(page).to have_content('Oooops, No Tickets Found')
    end

    # dont forget to work on this
    # scenario 'should not show tickets if api is down' do
    #   visit root_path
    #   expect(response).to have_http_status(200)
    # end
  end

  context 'show individual ticket' do
    # make text more dynamic
    scenario 'should show an individual ticket if it exist' do
      visit root_path
      tr = page.find(:xpath, ".//tr[./td[@class='ticketID'][text()='202']]")
      expect(tr).to have_css('td.oneTicket', text: 'Show')
      tr = page.find(:xpath, ".//tr[./td[@class='ticketID'][text()='202']]").click_link('Show')
      expect(page).to have_content('Ticket Viewer')
      expect(page).to have_content('Ticket ID')
      expect(page).to have_content('Subject')
      expect(page).to have_content('Description')
      expect(page).to have_link 'Back', href: tickets_path
    end
    scenario 'ticket does not exist' do
    end
  end
end
