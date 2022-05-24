require 'rails_helper'

RSpec.describe 'login' do 
  let!(:user) { User.create(name: 'Jeff', email: 'jeff@email.com', password: 'abc', password_confirmation: 'abc') }
  let!(:admin) { User.create(name: 'admin', email: 'admin@email.com', password: 'abc', role:1) }
  before :each do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'logs in when credentials are correct' do 
  	visit '/login'

  	fill_in :email, with: 'jeff@email.com'
  	fill_in :password, with: 'abc'

  	click_on 'Log in'

  	expect(current_path).to eq(user_path(user))

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

  it 'requires login after logging out' do 
    visit '/login'

    fill_in :email, with: 'jeff@email.com'
    fill_in :password, with: 'abc'

    click_on 'Log in'
    click_on 'Log Out'

    visit user_path(user)
    expect(current_path).to eq('/login')
    expect(page).to have_content('Your session has expired, please log in again!')

  end

  it 'allows admin to view admin dashboard' do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit '/login'
    fill_in :email, with: 'admin@email.com'
    fill_in :password, with: 'abc'

    click_on 'Log in'
    expect(current_path).to eq('/admin/dashboard')

  end
end