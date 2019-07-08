# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user, :uuid

    def connect
      if !user_id
        self.uuid = session['id'] || reject_unauthorized_connection
      else
        self.current_user = find_verified_user
      end
    end

    def session
      @session ||= cookies.encrypted[Rails.application.config.session_options[:key]]&.with_indifferent_access || {}
    end

    def identifier
      @identifier ||= current_user || uuid
    end

    private

    def find_verified_user
      if user_id
        User.find(user_id)
      else
        reject_unauthorized_connection
      end
    end

    def user_id
      user_key = session['warden.user.user.key']
      return nil if user_key.blank? || user_key[0].blank?

      user_key[0][0]
    end
  end
end
