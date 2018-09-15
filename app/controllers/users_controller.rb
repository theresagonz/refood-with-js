class UsersController < ApplicationController
  def index
  end
    
  def show
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
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
