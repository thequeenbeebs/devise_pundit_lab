class UsersController < ApplicationController
    before_action :authenticate_user!
    def home
    end

    def show
        if current_user != nil
            @user = User.find_by(id: params[:id])
            if current_user.id != @user.id
                flash[:alert] = "Access denied."
                redirect_to root_path
            end
        else
            redirect_to root_path
        end
    end

    def new
        @user = User.new
    end

    def create
    end

    def edit
        @user = current_user
    end

    def update
    end

    def about
    end
end