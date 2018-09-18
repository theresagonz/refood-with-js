class ApplicationController < ActionController::Base

  private
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in
    !!session[:user_id]
  end
  
  def require_login
    if !logged_in
      flash[:error] = ["Please sign up or log in"]
      redirect_to signup_path if !logged_in
    end
  end

  def format_date(string)
    Time.strptime(string, '%m/%d/%Y %H:%M %p').strftime("%A, %B %d, %Y, %l:%M %P")
  end
  
  helper_method :current_user, :logged_in, :require_login, :format_date
end
