class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit]

  def ensure_correct_user
    if current_user.id != params[:id].to_i
      redirect_to user_path(current_user)
    end
  end
  def index
  	@users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
  	@user = User.find(params[:id])
  	@books = Book.where(user_id: params[:id])
    @book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "You have updated user successfully."
    else
      render "users/edit"
    end
  end

  private

  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
