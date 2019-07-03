# frozen_string_literal: true

class Message < ActiveRecord::Base
  belongs_to :user, optional: true

  # I could have used string type which limited by 255, but message length
  # could be increased in the future and changing rails validation is easier
  validates :body, presence: true, length: { maximum: 200 }
end
