class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_admin
    current_user && current_user.admin?
  end
  helper_method :current_admin

  def require_admin
    redirect_to root_path unless current_user && current_user.admin?
  end

  def site_description
    "Ruby, Rails, AngularJS, Design Patterns"
  end
  helper_method :site_description
end
