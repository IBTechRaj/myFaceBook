class UsersController < ApplicationController
  def index
    @users = User.where('id != ?', current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts
    @comment = @post.comments.build
    @comments = @post.comments
  end
end
