module MessageHelper
  UNAUTH_USER_NAME = 'Anonymous'

  def message_creator(message)
    return UNAUTH_USER_NAME if message.user.nil?

    message.user.email.split('@').first
  end
end
