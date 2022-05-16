require 'rails_helper'

RSpec.describe 'user dashboard' do
  let!(:user1) { User.create(name: 'Jeff', email: 'jeff@email.com', password: 'abc', password_confirmation: 'abc') }

  before(:each) do
    visit user_path(user1)
  end

  it 'shows page title with user name' do
    expect(page).to have_content("Jeff's Dashboard")
    expect(page).to_not have_content("Amy's Dashboard")
  end

  it 'has a button to discover movies' do
    expect(page).to have_link('Discover Movies')
  end

  it 'has a section for viewing parties' do
    expect(page).to have_content('Viewing Parties')
  end

  it 'has link to discover page' do
    visit user_path(user1)
    click_on 'Discover Movies'

    expect(current_path).to eq "/users/#{user1.id}/discover"
  end

   describe 'friends' do 
      let!(:alicia) { User.create(name: 'Alicia', email: 'alicia@email.com', password: 'abc', password_confirmation: 'abc') }
    it 'can search and add a friend in the db' do 
      
      within(".friends") do 
        fill_in :email, with: 'alicia@email.com'
        click_on 'Add Friend'
      end

        expect(current_path).to eq "/users/#{user1.id}"
        expect(page).to have_content("Alicia is added as a friend. Invite them to your next Viewing Party!")
    end

    it 'can not add self' do 
      
      within(".friends") do 
        fill_in :email, with: 'jeff@email.com'
        click_on 'Add Friend'
      end

      expect(current_path).to eq "/users/#{user1.id}"
      expect(page).to have_content("You're already your best friend-no need to make it official!
")
    end

    it 'can not add existing friends' do 
      Friendship.create(user: user1, friend: alicia)
      within(".friends") do 
        fill_in :email, with: 'alicia@email.com'
        click_on 'Add Friend'
      end

        expect(current_path).to eq "/users/#{user1.id}"
        expect(page).to have_content("Alicia is already your friend-try a different email!")
      end

    it 'can not add non-existing users' do 
      Friendship.create(user: user1, friend: alicia)
      within(".friends") do 
        fill_in :email, with: 'aliciawow@email.com'
        click_on 'Add Friend'
      end
      
      expect(current_path).to eq "/users/#{user1.id}"
      expect(page).to have_content("Doesn't seem like your friend has an account yet, invite them to join Viewing Party!
")
      end
  end
end
