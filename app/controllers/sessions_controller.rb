class SessionsController < ApplicationController
  layout "application_no_login_link"
  before_action :require_login, only: [:destroy]
  before_action :redirect_to_index_if_logged_in, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if !user
      flash.now[:error] = ["Email not found. Please try again."]
      render :new
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to index_path
    else
      flash.now[:error] = ["Invalid password. Please try again."]
      render :new
    end
  end

  def create_with_google
    @user = User.find_by(email: auth[:email]) 
    if @user
      session[:user_id] = @user.try(:id)
      redirect_to index_path
    else
      @user = User.new(email: auth[:email], name: auth[:first_name], password: SecureRandom.urlsafe_base64(n=6))
      if @user.save
        @user.build_giver
        @user.build_receiver
        @user.save

        session[:user_id] = @user.try(:id)
        flash.now[:message] = "Welcome to Refood!"
        render :'users/add_info'
      else
        flash.now[:error] = ["There was a problem with your Google login"
        ]
        render :'users/new'
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

    def auth
      request.env['omniauth.auth'][:info]
    end
end
