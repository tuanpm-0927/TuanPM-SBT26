class PostsController < ApplicationController
  before_action :load_post, only: [:edit, :update, :show, :destroy]
  before_action :check_current_user, except: %i[show]
  before_action :check_user_post, only: :destroy

  def index
    @q = Post.ransack(params[:q]) 
    if params[:q].nil?
      @posts = current_user.posts.order_by_newest.paginate page: params[:page], per_page: Settings.def_perpage
    else
      @posts = @q.result(distinct: true).where(user_id: current_user.id).paginate page: params[:page], per_page: Settings.def_perpage
    end
  end

  def new
    @post = Post.new
  end

  def show
    @comments = @post.comments.order_by_newest
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
  def check_current_user
    unless current_user 
      flash[:danger] = t ".please_login"
      redirect_to login_path
    end
  end

  def params_post
    params.require(:post).permit(:title, :content, :category_id) 
  end

  def check_user_post
    if logged_in?
      return true if @post.user_id == current_user.id
    end
  end

  def load_post
    @post = Post.find_by(id: params[:id])
    return if @post
    flash[:danger] = t ".post_notfound"
    redirect_to notfound_path
  end
end
