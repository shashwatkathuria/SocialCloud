class UsersController < ApplicationController
    include ActionView::Helpers::DateHelper
    include UsersHelper
    skip_before_action :authenticate_user!, only: [:search, :show_profile]
    def index
      if params[:format] == "json"
          @user = current_user
          @followers = []
          for followerID in current_user.followers
            @followers.push(User.find(followerID))
          end
          @following = []
          for followingID in current_user.following
            @following.push(User.find(followingID))
          end

          @following = filterFollowDetailsForJson(@following, current_user.following)
          @followers = filterFollowDetailsForJson(@followers, current_user.following)
          respond_to do |format|
          format.json {render json: {user: @user.as_json(only: [:first_name, :last_name, :username, :phone, :email]),
                            member_since: time_ago_in_words(@user.created_at),
                            following: @following,
                            followers: @followers} }
          end
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
        if params[:format] == "json"
          @showUser = User.where(username: params[:username]).first
          if @showUser != nil
            @posts = []
            Post.where(user_id: @showUser.id).each do |post|
              @posts.push({image_caption: post.image_caption, image_heading: post.image_heading, url: post.post_image.url, time: time_ago_in_words(post.time) })
            end
          end

          if current_user
            if current_user.following.include? @showUser.id
              @link = url_for action:"unfollow", controller: "users", username: @showUser.username
            else
              @link = url_for action:"follow", controller: "users", username: @showUser.username
            end
            respond_to do |format|
              format.json {render json: {user: @showUser.as_json(only: [:first_name, :last_name, :username]),
                                link: @link,
                                posts: @posts.as_json(except: :_id)} }
            end
          else
            respond_to do |format|
              format.json {render json: {user: @showUser.as_json(only: [:first_name, :last_name, :username]),
                                posts: @posts.as_json(except: :_id)} }
            end
          end

        end

        if User.where(username: params[:username]).first == nil
          flash[:alert] = "No such user by the username " + params[:username] + "."
          redirect_to root_path
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
        else#if request.method == "GET"
          if params[:format] == "json"

            if params[:searchQuery] == nil
              params[:searchQuery] = ""
              @users = User.where("first_name like ? or last_name like ? or username like ?", "%" + params[:searchQuery] + "%", "%" + params[:searchQuery] + "%", "%" + params[:searchQuery] + "%")
            elsif params[:searchQuery] == ""
              flash[:alert] = "No search query entered."
              redirect_to root_path
            else
              @users = User.where("first_name like ? or last_name like ? or username like ?", "%" + params[:searchQuery] + "%", "%" + params[:searchQuery] + "%", "%" + params[:searchQuery] + "%")
            end

            @users = filterSearchResultsForJson(@users)
            respond_to do |format|
              format.json {render json: {search_results: @users} }
            end

          end
        end
    end

end
