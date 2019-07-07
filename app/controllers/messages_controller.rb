# frozen_string_literal: true

class MessagesController < ApplicationController
  def index
    @messages = Message.all
  end

  def create
  end

  def update
  end

  def destroy
  end
end
