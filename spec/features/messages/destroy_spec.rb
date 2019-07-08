# frozen_string_literal: true

require 'rails_helper'

feature 'Destroy message', js: true do
  let!(:message) { create(:message) }

  background do
    visit root_path
    find("#destroy_message_#{message.id}").click
  end

  scenario 'User do not see deleted message' do
    page.evaluate_script('window.location.reload()') # We should have separate specs for cable
    expect(page).to_not have_content(message.body)
  end
end
