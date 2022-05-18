require 'rails_helper'

RSpec.describe 'new party page' do
  let!(:user1) { User.create(name: 'person1', email: 'email1@email1.com', password: 'password', password_confirmation: 'password') }
  let!(:user2) { User.create(name: 'person2', email: 'email1@email2.com', password: 'password', password_confirmation: 'password') }
  let!(:user3) { User.create(name: 'person3', email: 'email1@email3.com', password: 'password', password_confirmation: 'password') }
  let!(:user4) { User.create(name: 'person4', email: 'email1@email4.com', password: 'password', password_confirmation: 'password') }

  before(:each) do
    details = JSON.parse(File.read('spec/fixtures/movie_details.json'), symbolize_names: true)
    allow(TmdbService).to receive(:movie_details).and_return(details)
    cast = JSON.parse(File.read('spec/fixtures/movie_cast.json'), symbolize_names: true)
    allow(TmdbService).to receive(:movie_cast).and_return(cast)
    review = JSON.parse(File.read('spec/fixtures/movie_review.json'), symbolize_names: true)
    allow(TmdbService).to receive(:movie_review).and_return(review)
    Friendship.create(user: user1, friend:user2)
    Friendship.create(user: user1, friend:user3)
    Friendship.create(user: user1, friend:user4)

    visit "users/#{user1.id}/movies/545611/viewing_party/new"
  end

  it 'can create new party' do
    within(".friend-#{user2.id}") do
      page.check
    end
    click_on 'Create'

    expect(current_path).to eq(user_path(user1))
    expect(page).to have_content("#{user1.name}'s Dashboard")
  end

  it 'shows error message when unable to create party' do
    fill_in :duration_user, with: 80
    click_button('Create')

    expect(current_path).to eq("/users/#{user1.id}/movies/545611/viewing_party/new")
    expect(page).to have_content('Duration cannot be shorter than movie runtime')
  end
end
