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
        if request.method == "POST"
          if params[:searchQuery] == ""
            flash[:alert] = "No search query entered."
            redirect_to root_path
          else
            redirect_to url_for action: "search", controller: "users", searchQuery: params[:searchQuery]
          end
        else
          if params[:searchQuery] == ""
            flash[:alert] = "No search query entered."
            redirect_to root_path
          else
            @users = User.where("first_name like ? or last_name like ?", "%" + params[:searchQuery] + "%", "%" + params[:searchQuery] + "%")
          end
        end
    end

end
