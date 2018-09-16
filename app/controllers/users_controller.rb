class UsersController < ApplicationController
  layout "application_no_login_link", only: [:new]
  before_action :require_login, only: [:show]

  def index
  end
    
  def show
  end

  def new
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.build_giver
      user.build_receiver
      user.save
      redirect_to '/index'
    else
      flash[:error] = user.errors.full_messages.uniq
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :zip_code, :password, :password_confirmation)
  end
end
