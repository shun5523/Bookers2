class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, {only: [:edit, :update]}
  # protect_from_forgery :except => [:show]
  def show
  	@user = User.find(params[:id])
  	@book = Book.new
  	@books = Book.all
  	# @users = User.all
  end

  def index
  	@users = User.all
  	@book = Book.new
  	@user = current_user
  end

  def edit
  	   @user = User.find(params[:id])
  end

  def update
	     @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "The profile was successfully edited"
	     redirect_to user_path(@user)
    else
       flash[:notice] = "error"
       render 'edit'
    end
  end

private
  def user_params
  	  params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
       if current_user != @user
          redirect_to user_path(current_user)
    end
  end
end