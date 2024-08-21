require 'rails_helper'

RSpec.describe 'User discover Page' do
  before(:each) do
    @user1= User.create!(name: 'Tommy', email: 'tommyiscool@gmail.com')
  end
  # US1
  it 'When a user visits "/users/:id/discover page, I see a button to Discover Top Rated Movies' do
    visit discover_user_path(@user1.id)
    within '#discover-button' do
      expect(page).to have_button('Discover Top Rated Movies')
    end
  end

  it 'has a text field to enter keywords to search by movie title.' do
    visit discover_user_path(@user1.id)
    within '#search-field' do
      expect(page).to have_field('Search for a movie')
      expect(page).to have_button('Search')
    end
  end

  it 'has a button to search by movie tittle' do
    visit discover_user_path(@user1.id)
    within '#search-field' do
      expect(page).to have_button('Search')
    end
  end
end
