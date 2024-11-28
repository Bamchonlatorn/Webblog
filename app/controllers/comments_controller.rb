class CommentsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.create(comment_params.merge(user_id: current_user.id))
  
      if @comment.save
        redirect_to @post, notice: 'Comment was successfully added.'
      else
        redirect_to @post, alert: 'Failed to add comment.'
      end
    end
  
    def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy
      redirect_to post_path(@comment.post), notice: 'Comment was successfully deleted.'
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  