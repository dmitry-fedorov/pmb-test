module ApplicationCable
  class Channel < ActionCable::Channel::Base
    delegate :session, :identifier, to: :connection
  end
end
