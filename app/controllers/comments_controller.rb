class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_filter :is_member_of_training!

  def new
    @training = Training.find(params[:training_id])
    @comment = @training.comments.build
  end

  def create
    @training = Training.find(params[:training_id])
    @comment = @training.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @training, :notice => "Comment added!"
    end
  end

  def destroy

  end

  private
  def comment_params
    params.require(:comment).permit(:text)
  end
end
