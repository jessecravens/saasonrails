module UsersHelper
  def owner?(user)
    current_user == user
  end
end
