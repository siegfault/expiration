# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Delete users' do
  it 'user deletes their user' do # rubocop:disable RSpec/ExampleLength
    user = create(:user, first_name: 'Daffy', last_name: 'Duck')
    visit root_path
    mock_auth_hash(user: user)
    click_link_or_button 'Sign in with Google'

    click_link_or_button 'Daffy Duck'
    click_link_or_button('Permanently delete user')
    expect(page).to have_button 'Sign in with Google'
  end
end
