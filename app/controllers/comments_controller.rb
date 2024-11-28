class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post
  before_action :find_comment, only: [:destroy]

  def create
    @comment = @post.comments.create(comment_params.merge(user_id: current_user.id))

    if @comment.save
      redirect_to @post, notice: 'Comment was successfully added.'
    else
      redirect_to @post, alert: 'Failed to add comment.'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])  # ดึงโพสต์ที่เกี่ยวข้องกับคอมเมนต์
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: 'Comment was successfully deleted.'
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
