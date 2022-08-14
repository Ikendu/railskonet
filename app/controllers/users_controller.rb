class UsersController < ApplicationController

  before_action :authenticate_user, {only: [:index, :edit, :update, :show]}
  before_action :forbid_login_user, {only: [:login, :create, :login_form, :new]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name], 
      email: params[:email], 
      password: params[:password], 
      image_name: "gift.jpg"
      )
    
    if @user.save
      session[:user_id] = @user.id
       flash[:notice] = "You have successfully created an account"
       redirect_to("/users/#{@user.id}")
     else
      render("users/new")
    end

  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    @user.password = params[:password]

    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = "Your account has been updated successfully"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end

  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:notice] = "You have successfully deleted the user"
    redirect_to("/users/index")
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email] )
    
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "You have successfully login"
      redirect_to("/posts/index")
    else
      @error_message = "Invalid details"
      @email = params[:email]
      @password = params[:password]
      render("login_form")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You have successfully logout"
    redirect_to("/login")
  end


  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def ensure_correct_user
      if @current_user.id != params[:id].to_i
        flash[:notice] = "Unauthorized access"
        redirect_to("/posts/index")
      end
   end

end
