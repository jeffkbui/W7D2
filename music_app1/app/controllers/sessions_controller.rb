class SessionsController < ApplicationController
    def new
        @user = User.new
    end

    def create 
        @user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password]
        )

        if @user
            login(@user)
            redirect_to new_user_url
        else
            flash.now[:error] = ["Invalid Credentials"]
            render :new
        end
    end

    def destroy
        logout
        redirect_to new_user_url
    end
end
