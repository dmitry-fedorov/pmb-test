class MessagePolicy < ApplicationPolicy
  def manage?
    user == record.user
  end
end
