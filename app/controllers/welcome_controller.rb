class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    if user_signed_in?
        @posts = Post.all.order_by(time: :desc)
    else
        @posts = Post.all.sample(3)
    end
    @users = User.all
  end
end
