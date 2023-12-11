module SessionHelper
  def logged_in?
    !current_user.nil?
  end

  def current_user
    if (user_id = session[:user_id])
      #@current_user ||= User.find_by(id: user_id)
      user = User.find_by(id: user_id)
      if user && session[:session_token] == user.session_token
        @current_user=user
      end

    elsif cookies.encrypted[:user_id]
      user = User.find_by(id: cookies.encrypted[:user_id])
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @curent_user=user
      end
    end
  end
end
