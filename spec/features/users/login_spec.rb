require 'rails_helper'

RSpec.describe 'login' do 
  let!(:user1) { User.create(name: 'Jeff', email: 'jeff@email.com', password: 'abc', password_confirmation: 'abc') }
  
  it 'logs in when credentials are correct' do 
  	visit '/login'

  	fill_in :email, with: 'jeff@email.com'
  	fill_in :pasfsword, with: 'abc'

  	clic

  end



end