# frozen_string_literal: true

require 'rails_helper'

feature 'Create message', js: true do
  let(:message) { build(:message) }

  background do
    visit root_path
    click_on('Add message')
  end

  scenario 'User sees new message and "Add message" link' do
    fill_in('message_body', with: message.body)
    click_on('Create Message')
    page.evaluate_script('window.location.reload()') # We should have separate specs for cable
    expect(page).to have_content(message.body)
    expect(page).to have_link('Add message')
    expect(page).to have_content('Posted by Anonymous')
  end

  scenario 'User do not see message if validation is failed' do
    click_on('Create Message')
    expect(page).to_not have_content(message.body)  # ideally should check flash message errors
  end

  scenario 'User clicks on Cancel and does not see message' do
    fill_in('message_body', with: message.body)
    click_on('Cancel')
    page.evaluate_script('window.location.reload()') # We should have separate specs for cable
    expect(page).to_not have_content(message.body)
    expect(page).to have_link('Add message')
  end
end
