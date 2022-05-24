require 'rails_helper'

RSpec.describe 'new user page' do
  before(:each) do
    visit '/register'
  end

  it 'can create new user' do
    fill_in :name, with: 'Greg'
    fill_in :email, with: 'greg@email.com'
    fill_in :password, with: 'greg1012'
    fill_in :password_confirmation, with: 'greg1012'
    click_button('Register')
    user = User.last

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("#{user.name}'s Dashboard")
    expect(page).to have_content("Welcome, #{user.name}!")
    
  end

  it 'shows error message when wrong info is entered' do
    User.create!(name: 'greg', email: 'greg@email.com', password: 'abc', password_confirmation: 'abc')

    fill_in :name, with: 'Greg2'
    fill_in :email, with: 'greg@email.com'
    fill_in :password, with: 'greg1012'
    fill_in :password_confirmation, with: 'greg1012'
    click_button('Register')

    expect(current_path).to eq('/register')
    expect(page).to have_content('Email has already been taken')
  end

  it 'shows error message when password and password_confirmation do not match' do
    fill_in :name, with: 'Greg2'
    fill_in :email, with: 'greg@email.com'
    fill_in :password, with: 'greg1012'
    fill_in :password_confirmation, with: 'greg1011'
    click_button('Register')

    expect(current_path).to eq('/register')
    expect(page).to have_content("Password confirmation doesn't match Password")
  end
end
