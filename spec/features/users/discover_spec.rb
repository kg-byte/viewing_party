require 'rails_helper'

RSpec.describe 'users discover' do
  let!(:user1) { User.create(name: 'Jeff', email: 'jeff@email.com', password: 'abc', password_confirmation: 'abc') }

  before(:each) do
    visit '/login'

    fill_in :email, with: 'jeff@email.com'
    fill_in :password, with: 'abc'

    click_on 'Log in'
    visit '/dashboard/discover'
  end

  it 'has button to user_movies index page which shows 20 top movies', :vcr do
    expect(page).to have_link('Top Movies')

    click_link 'View Top Movies'

    expect(current_path).to eq(dashboard_movies_path)

    expect(page).to have_content('The Shawshank Redemption')
    expect(page).to have_content("Gabriel's Inferno: Part III")
  end

  describe 'search happy path' do
    it 'can search by keyword and return relavant movies if exists' do
      dog1 = MovieDetail.new(genre: nil, id: 1, runtime: 120, summary: 'a dog movie', title: 'Wiener-Dog',
                             vote_average: 7.3)
      dog2 = MovieDetail.new(genre: nil, id: 2, runtime: 120, summary: 'a dog movie',
                             title: 'Rock Dog 2: Rock Around the Park', vote_average: 7.0)
      dog3 = MovieDetail.new(genre: nil, id: 3, runtime: 130, summary: 'a dog movie',
                             title: 'Straight Outta Nowhere: Scooby-Doo! Meets Courage the Cowardly Dog', vote_average: 7.6)
      dogs = [dog1, dog2, dog3]

      allow(MovieFacade).to receive(:search).and_return({ total_results: 3, movies: dogs })

      fill_in :keyword, with: 'dog'
      click_button 'Search'

      expect(current_path).to eq(dashboard_movies_path)
      expect(page).to have_content('Straight Outta Nowhere: Scooby-Doo! Meets Courage the Cowardly Dog')
      expect(page).to have_content('Wiener-Dog')
    end
  end

  describe 'search sad path' do
    it 'returns error message if no keyword match' do
      allow(MovieFacade).to receive(:search).and_return({ total_results: 0,
                                                          movies: [] })
      fill_in :keyword, with: 'doggggggg'
      click_button 'Search'

      expect(page).to have_content('Total results: 0')
    end
  end
end
