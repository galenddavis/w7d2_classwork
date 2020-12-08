class UsersController < ApplicationController

    before_action :require_no_user!, only: [:new, :create]
    before_action :require_user!, only: [:show]

    def new
        @user = User.new
        render :new
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    def create
        user = User.new(user_params)
        if user.save
            login_user!(user) #sets the session session_token to a new session_token <= links to app_controller login_user
            redirect_to user_url(user.id)
        else
            flash.now[:errors] = user.errors.full_messages
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :session_token, :password_digest, :password) #<= need to pass :password in order to get password_digest
    end
end
