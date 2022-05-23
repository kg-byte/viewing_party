require 'rails_helper'

RSpec.describe 'login' do 
  let!(:user1) { User.create(name: 'Jeff', email: 'jeff@email.com', password: 'abc', password_confirmation: 'abc') }
  
  it 'logs in when credentials are correct' do 
  	visit '/login'

  	fill_in :email, with: 'jeff@email.com'
  	fill_in :password, with: 'abc'

  	click_on 'Log in'

  	expect(current_path).to eq(user_path(user1))

  end

    it 'shows error message when username is incorrect' do 
  	visit '/login'

  	fill_in :email, with: 'jeffi@email.com'
  	fill_in :password, with: 'abc'

  	click_on 'Log in'

  	expect(current_path).to eq('/login')
  	expect(page).to have_content('Incorrect Credentials. Please try again!')
  end 


  it 'shows error message when password is incorrect' do 
  	visit '/login'

  	fill_in :email, with: 'jeff@email.com'
  	fill_in :password, with: 'abd'

  	click_on 'Log in'

  	expect(current_path).to eq('/login')
  	expect(page).to have_content('Incorrect Credentials. Please try again!')
  end 


end