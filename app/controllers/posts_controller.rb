class PostsController < ApplicationController

  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

#ALWAYS REMEMBER TO CONVERT user_id TO INTEGER WHEN COMPARING, 
#It was mistakenly initialized to string at the database table

  def index
    @posts = Post.all.order( created_at: :desc)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @likes_counter = Like.where(post_id: @post.id).count
   
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(content: params[:content], user_id: @current_user.id)
    if @post.save
      flash[:notice] = "Post is successfully "
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
       flash[:notice] = "Post successfully updated"
       redirect_to("/posts/index")
     else
      render("posts/edit")
     end
  end

    def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "Post successfully deleted"
    redirect_to("/posts/index")
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id.to_i != @current_user.id
      flash[:notice] = "Unauthorized access"
      redirect_to("/posts/index")
    end
  end

end
