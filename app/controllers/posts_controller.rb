class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update show destroy]

  def new
  end

  def create
  end

  def destroy
  end

  def update
  end

  def index
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
