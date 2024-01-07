# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'user authentication' do
  it 'user logs in with google auth' do
    visit root_path
    expect(page).to have_button('Sign in with Google')
    mock_auth_hash
    click_link_or_button 'Sign in with Google'
    expect(page).to have_content('Michael Siegfried')
  end

  it 'user logs out' do # rubocop:disable RSpec/ExampleLength
    mock_auth_hash
    visit root_path
    expect(page).to have_button('Sign in with Google')
    click_link_or_button 'Sign in with Google'
    expect(page).to have_link('Logout')
    click_link_or_button 'Logout'
    expect(page).to have_button('Sign in with Google')
  end

  it 'user token expired' do
    visit root_path
    expect(page).to have_button('Sign in with Google')
    mock_auth_hash(expires_at: 1.hour.ago)
    click_link_or_button 'Sign in with Google'
    expect(page).to have_button('Sign in with Google')
  end
end
