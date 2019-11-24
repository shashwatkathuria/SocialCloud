class UsersController < ApplicationController
    skip_before_action :authenticate_user!, only: [:search, :show_profile]
    def index
        if current_user
          @user = current_user
          @followers = []
          for followerID in current_user.followers
            @followers.push(User.find(followerID))
          end
          @following = []
          for followingID in current_user.following
            @following.push(User.find(followingID))
          end
        else
          redirect_to '/login'
        end
    end

    def follow

      @user = User.where(username: params[:username]).first
      if @user.id  == current_user.id
        redirect_to url_for action: "show_profile", controller: "users", username: @user.username
      end
      if @user.followers.include? current_user.id
      else
        @user.followers.push(current_user.id)
        @user.save
      end

      if current_user.following.include? @user.id
      else
        current_user.following.push(@user.id)
        current_user.save
      end

      redirect_to url_for action: "show_profile", controller: "users", username: @user.username
    end

    def unfollow

      @user = User.where(username: params[:username]).first

      if @user.id  == current_user.id
        redirect_to url_for action: "show_profile", controller: "users", username: @user.username
      end

      if @user.followers.include? current_user.id
        @user.followers.delete(current_user.id)
        @user.save
      else
      end

      if current_user.following.include? @user.id
        current_user.following.delete(@user.id)
        current_user.save
      else

      end

      redirect_to url_for action: "show_profile", controller: "users", username: @user.username

    end

    def show_profile
        @user = User.where(username: params[:username]).first
        if @user == nil
          flash[:alert] = "No such user by the username " + params[:username] + "."
        else
          @posts = Post.where(user_id: @user.id)
        end
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
          if params[:searchQuery] == nil
            params[:searchQuery] = ""
            @users = User.where("first_name like ? or last_name like ? or username like ?", "%" + params[:searchQuery] + "%", "%" + params[:searchQuery] + "%", "%" + params[:searchQuery] + "%")
          elsif params[:searchQuery] == ""
            flash[:alert] = "No search query entered."
            redirect_to root_path
          else
            @users = User.where("first_name like ? or last_name like ? or username like ?", "%" + params[:searchQuery] + "%", "%" + params[:searchQuery] + "%", "%" + params[:searchQuery] + "%")
          end
        end
    end

end
