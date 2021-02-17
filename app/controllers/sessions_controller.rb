class SessionsController < ApplicationController
  def new
    user_login?
  end

  def store_login
    user_login?
  end

  def create
    key = params.keys.find{ |n| n=~ /.+_session/}.to_sym
    pr = params[key]
    login(key, pr)
    redirect_to stores_path
  end

  def destroy
    session.delete(:user_id)
    redirect_to new_session_path
  end
end
