# frozen_string_literal: true

class MessagesChannel < ApplicationCable::Channel
  def subscribed
    ActiveRecord::Base.clear_active_connections!
    stream_from 'messages'
  end
end
