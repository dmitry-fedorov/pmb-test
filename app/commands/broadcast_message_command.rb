# frozen_string_literal: true

class BroadcastMessageCommand
  attr_reader :message, :user

  MESSAGE_CHANNEL_NAME = 'messages'
  MESSAGE_PARTIAL_PATH = 'messages/message'

  def initialize(message, user)
    @message = message
    @user = user
  end

  def create
    ActionCable.server.broadcast(
      MESSAGE_CHANNEL_NAME,
      action: __method__.to_s,
      id: message.id,
      html: snippet
    )
  end

  def update
    ActionCable.server.broadcast(
      MESSAGE_CHANNEL_NAME,
      action: __method__.to_s,
      id: message.id,
      html: snippet
    )
  end

  def destroy
    ActionCable.server.broadcast(
      MESSAGE_CHANNEL_NAME,
      action: __method__.to_s,
      id: message.id
    )
  end

  private

  def snippet
    ApplicationController.render(
      partial: MESSAGE_PARTIAL_PATH,
      locals: { message: message, current_user: user }
    )
  end
end
