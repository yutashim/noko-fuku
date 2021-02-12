class SessionsController < ApplicationController
  def new
  end

  def store_login
  end

  def create
    key = params.keys.find{ |n| n=~ /.+_session/}.to_sym
    pr = params[key]
    login(key, pr)
  end

  def destroy
  end
end
