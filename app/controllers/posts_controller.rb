class PostsController < ApplicationController
  def index
    if current_user
      @posts = Post.where(user_id:current_user.id).order_by(time: :desc).to_a
    else
      redirect_to '\login'
    end
  end

  def show
  end

  def new
  end

  def create
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
