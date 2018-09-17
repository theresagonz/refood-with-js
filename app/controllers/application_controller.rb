class ApplicationController < ActionController::Base

  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def require_login
    redirect_to login_path if !session[:user_id]
  end

  def format_date(string)
    Time.strptime(string, '%m/%d/%Y %H:%M %p').strftime("%A, %B %d, %Y, %l:%M %P")
  end
  
  helper_method :current_user, :require_login, :format_date
end
