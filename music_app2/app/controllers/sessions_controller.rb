class SessionsController < ApplicationController
    def new
        @user = User.new
        render :new
    end

    def create 
        @user = User.find_by_credentials(
            params[:user][:email], 
            params[:user][:password]
        )

        if @user
            log_in_user!(@user)
            session[:session_token] = @user.reset_session_token!
            redirect_to user_url
        else
            @user = User.new(email: params[:user][:email])
            flash.now[:errors] = ['Invalid Credentials']
            render :new
        end
    end

    def destroy
        logout
        redirect_to new_session_url
    end
end
