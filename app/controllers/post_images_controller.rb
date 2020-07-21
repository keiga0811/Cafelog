class PostImagesController < ApplicationController
  def new
  	@post = PostImage.new
  end

  def create
  	post = PostImage.new(post_image_params)
  	post.save
  	redirect_to post_images_path
  end

  def index
  	@posts = PostImage.all
  end

  def show
  end

  def edit
  end

  private
  def post_image_params
  	params.require(:post_image).permit(:title, :caption)
  end
end
