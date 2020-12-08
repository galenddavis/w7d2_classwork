class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end

    def show
        @user = User.find_by(params[:session_token]) #or [:id]?
        render :show
    end

    def create
        @user = User.new(user_params)
        if @user.save
            login_user!(@user) #sets the session session_token to a new session_token <= links to app_controller login_user
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    private

    def user_params
        params.require(:users).permit(:email, :session_token, :password_digest)
    end
end
