class SessionsController < ApplicationController
  layout "application_no_login_link"
  before_action :require_login, only: [:destroy]
  before_action :redirect_to_index_if_logged_in, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if !user
      flash[:error] = "Email not found. Please try again."
      render :new
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to index_path
    else
      flash[:error] = "Invalid password. Please try again."
      render :new
    end
  end

  def create_with_google
    user = User.find_or_create_by(email: auth[:info][:email]) do |user|
      user.name = auth[:info][:first_name]
      user.password = SecureRandom.urlsafe_base64(n=6)
    end
    user.build_giver
    user.build_receiver
    user.save
    session[:user_id] = user.try(:id)
    # @offers = current_user.giver.offers
    # @requests = current_user.receiver.requests
    redirect_to index_path
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

    def auth
      request.env['omniauth.auth']
    end
end
