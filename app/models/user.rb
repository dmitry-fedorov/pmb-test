# frozen_string_literal: true

class User < ActiveRecord::Base  
  devise :database_authenticatable, :registerable, :rememberable, :validatable

  has_many :messages
end
