class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = current_user.likes.new(post: @post)

    if @like.save
      redirect_to @post, notice: 'You liked this post!'
    else
      redirect_to @post, alert: 'Unable to like the post.'
    end
  end

  def destroy
    @like = current_user.likes.find_by(post: @post)
    @like.destroy if @like

    redirect_to @post, notice: 'You unliked this post.'
  end


  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
