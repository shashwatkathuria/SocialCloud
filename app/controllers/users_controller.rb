class UsersController < ApplicationController
    skip_before_action :authenticate_user!, only: [:search]
    def index
        if current_user
          @user = current_user
        else
          redirect_to '/login'
        end
    end

    def show
        @user = User.find(params[:id])
    end

    def search
        @users = User.where("first_name like ? or last_name like ?", "%" + params[:searchQuery] + "%", "%" + params[:searchQuery] + "%")
    end

end
