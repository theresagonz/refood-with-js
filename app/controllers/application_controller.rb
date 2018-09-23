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

  def redirect_to_index_if_not_authorized(params_id, resource)
    if params[params_id].to_i != current_user.id
      flash[:error] = ["Hey, that's not your #{resource}"]
      redirect_to index_path
    end
  end

  def redirect_to_index_if_not_authorized_to_edit_offer
    # DON'T AUTHORIZE: if the edit is for a request, params will have an offer_id and an id
    # AUTHORIZE: if the edit is for an offer, params will just have an id
    # AUTHORIZE: if it's a requests index page, params will have just offer_id, no id

    if !params[:offer_id] || params[:offer_id] && params[:id]
      offer = Offer.find_by(id: params[:id])
      if offer.user != current_user
        flash[:error] = ["Hey, that's not your offer"]
        redirect_to index_path
      end
    end
  end

  def redirect_to_index_if_not_authorized_to_edit_request
    # request = Request.find_by(id: params[:id])
    if Request.find_by(id: params[:id]).user != current_user
      flash[:error] = ["Hey, that's not your request"]
      redirect_to index_path
    end
  end


  def redirect_to_index_if_logged_in
    if logged_in
      redirect_to index_path
    end
  end

  def format_date(string)
    Time.strptime(string, '%m/%d/%Y %H:%M %p').strftime("%A, %B %d, %Y, %l:%M %P")
  end
 
  helper_method :current_user, :logged_in, :require_login, :format_date
end
