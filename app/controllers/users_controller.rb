class UsersController < ApplicationController
  def index
    @users = User.where('id != ?', current_user.id)
    @friendship = current_user.friendships.build
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts
    @comment = @post.comments.build
    @comments = @post.comments
    @friendship = current_user.friendships.build
  end
end
