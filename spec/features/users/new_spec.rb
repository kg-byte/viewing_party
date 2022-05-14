require 'rails_helper'

RSpec.describe 'new user page' do
  before(:each) do
    visit '/register'
  end

  it 'can create new user' do
    fill_in 'user[name]', with: 'Greg'
    fill_in 'user[email]', with: 'greg@email.com'
    fill_in 'user[password]', with: 'greg1012'
    fill_in 'user[password_confirmation]', with: 'greg1012'
    click_button('Register')
    user = User.last

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("#{user.name}'s Dashboard")
  end

  it 'shows error message when wrong info is entered' do
    User.create!(name: 'greg', email: 'greg@email.com', password: 'abc', password_confirmation: 'abc')

    fill_in 'user[name]', with: 'Greg2'
    fill_in 'user[email]', with: 'greg@email.com'
    click_button('Register')

    expect(current_path).to eq('/register')
    expect(page).to have_content('Error: please enter a name and unique email to register.')
  end
end
