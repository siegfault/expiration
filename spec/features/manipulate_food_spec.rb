# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Manipulate food', type: :feature do
  it 'user creates food' do # rubocop:disable RSpec/ExampleLength
    user = FactoryBot.create(:user)
    visit root_path
    mock_auth_hash(user: user)
    click_link 'Sign in with Google'

    expect(page).not_to have_text('My new great food')
    click_link 'Add New Item'
    click_button 'Create Food'
    expect(page).to have_text("Name can't be blank")
    expect(page).to have_text("Expiration can't be blank")

    fill_in 'food_name', with: 'My new great food'
    fill_in 'food_expiration', with: Date.tomorrow
    click_button 'Create Food'
    click_link 'filter_by_status_expiring'
    expect(page).to have_text('My new great food')
  end

  it 'user edits food' do # rubocop:disable RSpec/ExampleLength
    food = FactoryBot.create(:food, name: 'Changing food')

    visit root_path
    mock_auth_hash(user: food.user)
    click_link 'Sign in with Google'

    click_link 'filter_by_status_expiring'
    click_link "edit_food_#{food.id}"
    fill_in 'food_name', with: ''
    fill_in 'food_expiration', with: nil
    click_button 'Update Food'
    expect(page).to have_text("Name can't be blank")
    expect(page).to have_text("Expiration can't be blank")

    fill_in 'food_name', with: 'New Named food!'
    fill_in 'food_expiration', with: 1.year.from_now
    click_button 'Update Food'
    click_link 'filter_by_status_expiring'
    expect(page).to have_text('New Named food!')
  end
end
