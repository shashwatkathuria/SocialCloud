class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!
  def index
    @posts = Post.all.order_by(time: :asc)
    @users = User.all
  end
end
