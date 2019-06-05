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
      # should add click show link
     
    end

    scenario 'no tickets to show' do
      visit root_path
      expect(page).to have_content('Oooops, No Tickets Found')
    end

  end

  context 'show individual ticket' do
    scenario 'should show an individual ticket if it exist' do
      visit root_path

      expect(page).to have_content('Subject')
   
    end
    scenario 'ticket does not exist' do
    end
  end
end
