class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    respond_with(@post)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      if @post.picture.present?
        @post.picture = FileHandler.new(@post).save
      end
      flash[:success] = 'Post added successfully'
    else
      flash[:error] = 'Error saving post'
      render 'new' and return
    end
    respond_with(@post)
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'Post updated successfully'
    else
      flash[:error] = 'Error updating post'
      render 'edit' and return
    end
    respond_with(@post)
  end

  def destroy
    @comments = Comment.where(post_id: @post.id)
    @comments.destroy_all
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit!
    end
end
