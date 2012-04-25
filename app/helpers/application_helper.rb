module ApplicationHelper

  def name_or_email(user)
    user.profile.try(:full_name) || user.email
  end
end
