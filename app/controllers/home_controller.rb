class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :validate_company!

  def index
    @users = User.all
  end
end
