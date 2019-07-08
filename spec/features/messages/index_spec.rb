# frozen_string_literal: true

require 'rails_helper'

feature 'Messages index' do
  let!(:messages) { create_list(:message, 5) }

  background do
    visit '/'
  end

  scenario 'User sees all messages of the board' do
    messages.each do |message|
      expect(page).to have_content(message.body)
    end
  end
end
