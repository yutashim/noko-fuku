module SessionsHelper
  MODELS = { user_session: User, store_session: Store }
  
  def login(key, pr)
    login_user = MODELS[key].find_by(email: pr[:email])
    if login_user && login_user.authenticate(pr[:password])
      if key == :store_session
        session[:user_id] = "store_#{login_user.id}"
      else
        session[:user_id] = login_user.id
      end
    end
  end

  def current_user
    if session[:user_id] =~ /store_\d+/
      @current_user = Store.find(session[:user_id].gsub(/store_/, ''))
    else
      @current_user = User.find(session[:user_id])
    end
  end
end
