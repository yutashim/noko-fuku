class SessionsController < ApplicationController

  def home
  end

  def guest_login
    render :home
  end

  def new
    user_login?
  end

  def store_login
    user_login?
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
