# frozen_string_literal: true

require 'rails_helper'

feature 'update message', js: true do
  let!(:message) { create(:message) }

  background do
    visit root_path
    find("#update_message_#{message.id}").click
  end

  scenario 'User sees updated message' do
    fill_in('message_body', with: message.body + 'test')
    click_on('Update Message')
    page.evaluate_script('window.location.reload()') # We should have separate specs for cable
    expect(page).to have_content(message.body + 'test')
  end

  scenario 'User sees non-updated message' do
    fill_in('message_body', with: '')
    click_on('Update Message')
    page.evaluate_script('window.location.reload()') # We should have separate specs for cable
    expect(page).to have_content(message.body)
  end

  scenario 'User clicks on cancel and sees non-updated message' do
    fill_in('message_body', with: message.body + 'test')
    click_on('Cancel')
    page.evaluate_script('window.location.reload()') # We should have separate specs for cable
    expect(page).to have_content(message.body)
  end
end
