require 'rails_helper'

RSpec.describe 'Welcomes', type: :feature do
  describe 'GET /' do
    it 'displays welcome to Viewing Party Lite' do
      visit root_path

      expect(page).to have_content('Welcome to Viewing Party!')
      expect(page).to have_link 'Register'
      expect(page).to have_link 'Home'
    end

    it 'has button to new user page' do
      visit root_path

      click_on 'Register'

      expect(current_path).to eq '/register'
    end

    it 'has button to login' do
      visit root_path

      click_on 'Login'

      expect(current_path).to eq '/login'
    end
  end
end
