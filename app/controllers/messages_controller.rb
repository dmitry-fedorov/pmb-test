# frozen_string_literal: true

class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      # notify channel here
      head :created
    else
      head :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def message_params
    params.permit(:body)
  end
end
