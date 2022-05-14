require 'rails_helper'

RSpec.describe 'Welcomes', type: :feature do
  describe 'GET /' do
    it 'displays welcome to Viewing Party Lite' do
      visit root_path

      expect(page).to have_content('Welcome to Viewing Party!')
      expect(page).to have_link 'Register'
      expect(page).to have_link 'Existing Users'
      expect(page).to have_link 'Home'
    end

    it 'has links to user index page' do
      visit root_path
      click_link 'Existing Users'

      expect(current_path).to eq users_path
    end

    it 'has button to new user page' do
      visit root_path

      click_on 'Register'

      expect(current_path).to eq new_user_path
    end

    it 'has button to login' do 
      visit root_path

      click_on 'login'

      expect(current_path).to eq ''

    end
  end
end
