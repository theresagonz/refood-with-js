class ApplicationController < ActionController::Base

  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def require_login
    redirect_to login_path if !session[:user_id]
  end

  
  
  helper_method :current_user, :require_login
end
