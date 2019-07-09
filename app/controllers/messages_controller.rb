# frozen_string_literal: true

class MessagesController < ApplicationController
  def index
    session[:id] ||= SecureRandom.urlsafe_base64
    @messages = Message.all.order(created_at: :desc).page(params[:page]).per(23)
  end

  def new
    @message = Message.new

    respond_to :js
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save
      BroadcastMessageCommand.new(@message, current_user).create
      head :created
    else
      head :unprocessable_entity
    end
  end

  def edit
    @message = Message.find(params[:id])
    authorize(@message, :manage?)

    respond_to :js
  end

  def update
    @message = Message.find(params[:id])
    authorize(@message, :manage?)
    if @message.update(message_params)
      BroadcastMessageCommand.new(@message, current_user).update
      head :ok
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @message = Message.find(params[:id])
    authorize(@message, :manage?)
    if @message.destroy
      BroadcastMessageCommand.new(@message, current_user).destroy
      head :no_content
    else
      head :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
