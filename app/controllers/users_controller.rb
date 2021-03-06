class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_only, :except => [:create, :show, :new, :edit, :update, :destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  unless current_user.try(:admin?)
      unless logged_in? and current_user.id == @user.id
        flash[:danger] = "Access denied."
        redirect_to root_path
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)


      if @user.save
      log_in @user
      flash[:success] = "Welcome to the ShoeLace!"
      redirect_to @user

      else
     flash[:danger] = "Error creating account"
     render :new 
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
 
      if @user.update(user_params)
        flash[:success] = "Account is updated successfully."
        redirect_to @user
      else
        flash[:danger] = "Unprocessable Entity."
        render :edit
      end
    end
 

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
     flash[:notice] ='Account is deleted' 
     redirect_to shoes_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password,  :password_confirmation)
    end

    def admin_only
      unless current_user.try(:admin?)
        flash[:danger] = "Access denied."
        redirect_to root_path
      end
    end
end
