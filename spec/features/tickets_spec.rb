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

    
    # # dont forget to work on this
    # scenario 'should not show tickets if api is down' do
    #   visit root_path
    #   if (page.status_code == 500)
    #     expect(page).to 
    #   end
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

    scenario 'invalid ticket id' do
      # 404
      visit "/tickets/1000"
      expect(page.status_code == 404)
    end

    scenario 'ticket id does not exist' do
    end

    scenario 'within pagination' do
    end

    scenario 'over pagination page' do
    end
  end
end
