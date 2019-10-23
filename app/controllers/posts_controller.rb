class PostsController < ApplicationController
  def index
    @posts = Post.where(user_id:current_user.id).order_by(time: :desc)
  end

  def show
      @post = Post.find(params[:id])
      if @post.user_id != current_user.id
        flash[:alert] = "Invalid post."
        redirect_to posts_path
      end
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
    if request.method == "POST"
      redirect_to url_for action: "search", controller: "posts", searchQuery: params[:searchQuery]
    elsif request.method == "GET"
      @searchQuery = params[:searchQuery]
      @posts = Post.where(user_id:current_user.id).any_of({image_heading: /#{@searchQuery}/i}, {image_caption: /#{@searchQuery}/i}).order(:time=> 'asc')
    end
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
