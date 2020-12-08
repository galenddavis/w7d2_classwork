class SessionController < ApplicationController

    def new
        session = Session.new
        render :new
    end

    def create
        user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password])
        if user
            session[:session_token] = user.reset_session_token!
            redirect_to user_url(user) 
        else
            flash.now[:errors] = [ message: 'Ya don goofed']
            render :new
        end

    end

    def delete

    end

end
