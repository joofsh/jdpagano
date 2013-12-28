class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :load_blog


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


  private
  def load_blog
    @blog = Blog.find_by(subdomain: request.subdomain)
  end
end
