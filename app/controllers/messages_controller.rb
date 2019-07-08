# frozen_string_literal: true

class MessagesController < ApplicationController
  def index
    session[:id] ||= SecureRandom.urlsafe_base64
    @messages = Message.all
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      broadcast_message(@message, :create)
      head :created
    else
      head :unprocessable_entity
    end
  end

  def update
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
      broadcast_message(@message, :destroy)
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  def message_params
    params.permit(:body)
  end

  def broadcast_message(message, action)
    ActionCable.server.broadcast(
      'messages',
      action: action,
      id: message.id,
      html: html(message)
    )
  end

  def html(message)
    ApplicationController.render(
      partial: 'messages/message',
      locals: { message: message }
    )
  end
end
