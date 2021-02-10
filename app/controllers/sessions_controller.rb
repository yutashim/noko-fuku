class SessionsController < ApplicationController

  def new
  end

  def store_login
  end

  def create
    raise
    redirect_to new_session_path
  end

  def destroy
  end
end
