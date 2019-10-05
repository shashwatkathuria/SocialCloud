class PostsController < ApplicationController
  def index
    if current_user
      @posts = Post.where(user_id:current_user.id).order_by(time: :desc).to_a
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
      @posts = Post.any_of({image_heading: /#{@searchQuery}/i}, {image_caption: /#{@searchQuery}/i}).order_by(time: :desc).to_a
  end

  def delete
      @deleteID = params[:deleteID]
      Post.find(@deleteID).delete
      redirect_to posts_path
  end
end
