class PostsController < ApplicationController
  def index
    if current_user
      @posts = Post.where(user_id:current_user.id).to_a
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
  end

  def delete
  end
end
