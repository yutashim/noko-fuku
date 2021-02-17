class UsersController < ApplicationController
  before_action :current_user
  before_action :set_user
  before_action :prohibit_access, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @stores = @user.favorite_stores
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_digest)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def prohibit_access
    if @current_user != @user
      redirect_to stores_path
    end
  end
end
