class PostImagesController < ApplicationController
  def new
  	@post = PostImage.new
  end

  def create
  	post = PostImage.new(post_image_params)
    post.user_id = current_user.id
  	post.save
    post.errors.full_messages.each do |msg|
      p msg
    end
  	redirect_to post_images_path
  end

  def index
    @user = current_user
  	@posts = PostImage.page(params[:page]).reverse_order
  end

  def show
    @post = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = PostImage.find(params[:id])
  end

  def update
    post = PostImage.find(params[:id])
    post.update(post_image_params)
    redirect_to post_images_path
  end

  def destroy
    post = PostImage.find(params[:id])
    post.destroy
    redirect_to post_images_path
  end

  private
  def post_image_params
  	params.require(:post_image).permit(:user_id, :title, :caption, :image)
  end
end
