class PostsController < ApplicationController
  include ActionView::Helpers::DateHelper
  def index
    if params[:format] == "json"
      @posts = []
      Post.where(user_id:current_user.id).order_by(time: :desc).each do |post|
        @posts.push({ id: post._id.to_s, delete_path: url_for(action: "delete", controller: "posts", deleteID: post._id.to_s), post_path: post_path(post), image_caption: post.image_caption, image_heading: post.image_heading, image_base64: post.image_base64, image_content_type: post.image_content_type, time: time_ago_in_words(post.time) })
      end
      respond_to do |format|
        format.json {render json: {posts: @posts.as_json} }
      end
    end
  end

  def show
      if params[:format] == "json"
        begin
          @post = Post.find(params[:id])

          if @post.user_id != current_user.id
            flash[:alert] = "Invalid post."
            redirect_to posts_path
          end

          respond_to do |format|
            format.json {render json: { id: @post._id.to_s, delete_path: url_for(action: "delete", controller: "posts", deleteID: @post._id.to_s), image_caption: @post.image_caption, image_heading: @post.image_heading, image_base64: @post.image_base64, image_content_type: @post.image_content_type, time: time_ago_in_words(@post.time) } }
          end

        rescue
          flash[:alert] = "Invalid post."
          redirect_to posts_path
        end
      end

      if Post.find(params[:id]).user_id != current_user.id
        flash[:alert] = "Invalid post."
        redirect_to posts_path
      end

  end

  def new
    @post = Post.new
  end

  def create
    @params = params[:post]
    content = @params[:post_image].tempfile.open.read.force_encoding(Encoding::UTF_8)
    content_type = @params[:post_image].content_type
    @post = Post.new(user_id: current_user.id, image_heading: @params[:image_heading], image_caption: @params[:image_caption], image_base64: Base64.strict_encode64(content), image_content_type: content_type)
    @post.save
    redirect_to posts_path
  end

  def search
    if request.method == "POST"
      redirect_to url_for action: "search", controller: "posts", searchQuery: params[:searchQuery]
    elsif request.method == "GET"
      if params[:format] == "json"
        @searchQuery = params[:searchQuery]
        @posts = []
        Post.where(user_id:current_user.id).any_of({image_heading: /#{@searchQuery}/i}, {image_caption: /#{@searchQuery}/i}).order(:time=> 'desc').each do |post|
          @posts.push({ id: post._id.to_s, delete_path: url_for(action: "delete", controller: "posts", deleteID: post._id.to_s), post_path: post_path(post), image_caption: post.image_caption, image_heading: post.image_heading, image_base64: post.image_base64, image_content_type: post.image_content_type, time: time_ago_in_words(post.time) })
        end
        respond_to do |format|
          format.json {render json: {search_query: @searchQuery, search_results: @posts.as_json} }
        end
      end

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
