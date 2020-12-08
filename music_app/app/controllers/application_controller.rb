class ApplicationController < ActionController::Base
    helper_method :login_user!, :current_user

    def current_user                
        return nil unless session[:session_token]
        current_user ||= User.find_by(session_token: session[:session_token]) # <=  #user table ST, session ST
    end

    def logged_in?
        !!current_user
    end

    def ensure_login

    end

    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout_user

    end

    
end
