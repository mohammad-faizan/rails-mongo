class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:success] = 'Comment added successfully'
    else
      @post = Post.find(params[:post_id])
      flash[:error] = 'Error saving comment'
      render 'posts/show' and return
    end
    redirect_to post_path(params[:post_id])
  end

  def destroy
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit!
  end
end
