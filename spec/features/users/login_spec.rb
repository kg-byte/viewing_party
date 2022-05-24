require 'rails_helper'

RSpec.describe 'login' do 
  let!(:user) { User.create(name: 'Jeff', email: 'jeff@email.com', password: 'abc', password_confirmation: 'abc') }
  let!(:admin) { User.create(name: 'admin', email: 'admin@email.com', password: 'abc', role:1) }

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

    expect(current_path).to eq('/login')
    visit user_path(user)

  end

  it 'allows admin to view admin dashboard' do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    details = JSON.parse(File.read('spec/fixtures/movie_details.json'), symbolize_names: true)
    allow(TmdbService).to receive(:movie_details).and_return(details)
    party = create(:party, duration: 200, time: '209901011930') 
    movie = party.movie
    PartyUser.create(party: party, user: user, is_host: true)

    visit '/login'
    fill_in :email, with: 'admin@email.com'
    fill_in :password, with: 'abc'

    click_on 'Log in'

    expect(current_path).to eq('/admin/dashboard')
    expect(page).to have_content(movie.title)
    expect(page).to have_content(user.email)
  end

  it 'allows admin to delete a viewing party' do 
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    details = JSON.parse(File.read('spec/fixtures/movie_details.json'), symbolize_names: true)
    allow(TmdbService).to receive(:movie_details).and_return(details)
    party = create(:party, duration: 200, time: '209901011930') 
    movie = party.movie
    PartyUser.create(party: party, user: user, is_host: true)

    visit '/login'
    fill_in :email, with: 'admin@email.com'
    fill_in :password, with: 'abc'

    click_on 'Log in'
    click_on 'Delete Viewing Party'
    expect(current_path).to eq('/admin/dashboard')
    expect(page).to_not have_content(movie.title)
  end

end