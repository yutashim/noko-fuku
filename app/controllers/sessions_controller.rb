class SessionsController < ApplicationController
  MODELS = { user_session: User, store_session: Store }

  def new
  end

  def store_login
  end

  def create
    key = params.keys.find{ |n| n=~ /.+_session/}.to_sym
    pr = params[key]
    login_user = MODELS[key].find_by(email: pr[:email])
    if login_user && login_user.authenticate(pr[:password])
      session[key] = login_user.id
    end
    @login_user = login_user
  end

  def destroy
  end
end
