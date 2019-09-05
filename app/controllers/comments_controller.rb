class CommentsController < ApplicationController
<<<<<<< HEAD
  before_action :load_comment, only: :destroy
=======
  before_action :load_comment, only: [:destroy]
>>>>>>> ab44459cc02999983dacc04d58c8beeb6ee49ebd

  def create
    @comment = Comment.new params_comment
    if @comment.save
      load_comments_bypost
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    if @comment.destroy
      load_comments_bypost
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".error_delete"
      return notfound_path
    end
  end

  private
  def params_comment
    params.require(:comment).permit(:content, :user_id, :post_id)
  end

  def load_comment
    @comment = Comment.find_by(id: params[:id])
    unless @comment
      flash[:danger] = t ".notfound_comment"
<<<<<<< HEAD
      redirect_to notfound_path
=======
      return notfound_path
>>>>>>> ab44459cc02999983dacc04d58c8beeb6ee49ebd
    end
  end

  def load_comments_bypost
<<<<<<< HEAD
    post = Post.find_by(id: @comment.post_id)
    if post
      @comments = post.comments.order_new
    else
      flash[:danger] = t ".notfound_comment"
      redirect_to notfound_path
    end
=======
    @comments = Post.find_by(id: @comment.post_id).comments.order_new
>>>>>>> ab44459cc02999983dacc04d58c8beeb6ee49ebd
  end
end
