class UsersController < ApplicationController
  layout "application_no_login_link", only: [:new, :create]
  before_action :require_login, except: [:new, :create]
  before_action only: [:update, :destroy] do
    redirect_to_index_if_not_authorized('id', 'profile')
  end
  before_action :redirect_to_index_if_logged_in, only: [:new]
  before_destroy 

  def index
  end
    
  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.build_giver
      @user.build_requestor
      @user.save
      
      flash.now[:message] = "Hi #{@user.name}! Welcome to Refood!"
      session[:user_id] = @user.id
      render :'add_info'
    else
      flash.now[:error] = @user.errors.full_messages.uniq
      @user = User.new
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def add_info
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:message] = "Profile successfully updated"
      redirect_to '/index'
    else
      flash.now[:error] = @user.errors.full_messages
      render :edit
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def destroy
    current_user.delete
    session.delete :user_id
    flash[:message] = "Account successfully removed. Come back anytime!"
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:email, :name, :username, :address, :address2, :city, :state, :zip_code, :phone, :password, :password_confirmation)
    end
end
