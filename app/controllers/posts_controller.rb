class PostsController < ApplicationController
  before_action :load_post, only: [:edit, :update, :show, :destroy]

  def index
    @posts = Post.orderby.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @post = Post.new
  end

  def show
    @comments = @post.comments.order_new
  end

  def edit; end

  def update
    if @post.update_attributes(params_post)
      flash[:success] = t ".update_success"
      redirect_to posts_path
    else
      render :edit
    end
    
  end

  def create
    @post = current_user.posts.build(params_post)
    if @post.save
      flash[:success] = t ".create_success"
      redirect_to posts_path
    else
      render :new
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = t ".delete_success"
    else  
      flash[:danger] = t ".delete_failed"
    end
    redirect_to posts_path
  end

  private 
  def params_post
    params.require(:post).permit(:title, :content, :category_id) 
  end

  def load_post
    @post = Post.find_by(params[:id])
    return if @post
    flash[:danger] = t ".post_notfound"
    redirect_to notfound_path
  end
end
