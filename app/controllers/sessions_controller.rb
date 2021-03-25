class SessionsController < ApplicationController
before_action :user_login?, only: [:new, :store_login, :guest_login, :user_guest_login, :store_guest_login]
  def home
  end

  def new
  end

  def store_login
  end

  def new_guest_login
  end

  def user_guest_login
  end

  def store_guest_login
  end

  def create
    key = params.keys.find{ |n| n=~ /.+_session/}.to_sym
    pr = params[key]
    if login(key, pr)
      current_user
      redirect_to stores_path
    else
      flash.now[:notice] = ["ログインできませんでした"]
      flash.now[:notice] << "メールアドレスかパスワードに誤りが有ります"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end
end
