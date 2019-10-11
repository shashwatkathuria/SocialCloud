class PostsController < ApplicationController
  def index
    if current_user
      @posts = Post.where(user_id:current_user.id).order(:time=> 'asc').to_a
    else
      redirect_to '\login'
    end
  end

  def show
    @showID = params[:showID]
    @post = Post.find(@showID)
  end

  def new
    @post = Post.new
  end

  def create
    @params = params[:post]
    @post = Post.new(user_id: current_user.id, image_heading: @params[:image_heading], image_caption: @params[:image_caption], post_image: @params[:post_image])
    @post.save
    redirect_to posts_path
  end

  def search
      @searchQuery = params[:searchQuery]
      @posts = Post.where(user_id:current_user.id).any_of({image_heading: /#{@searchQuery}/i}, {image_caption: /#{@searchQuery}/i}).order(:time=> 'asc').to_a
  end

  def delete
      @deleteID = params[:deleteID]
      @post = Post.find(@deleteID)
      if @post.user_id == current_user.id
        @post.delete
        flash[:notice] = "Post successfully deleted."
        redirect_to posts_path
      else
        flash[:alert] = "You are not authorized to delete this post."
        redirect_to root_path
      end
  end
end
