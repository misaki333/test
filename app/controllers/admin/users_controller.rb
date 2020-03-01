class Admin::UsersController < ApplicationController
	def index
    if admin_signed_in?
		  @users = User.all
    else
      redirect_to root_path
    end
	end

	def show
    if admin_signed_in?
		  @user = User.find(params[:id])
    else
      redirect_to root_path
    end
	end

	def edit
    if admin_signed_in?
		  @user = User.find(params[:id])
    else
      redirect_to root_path
    end
	end

	def update
		@user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
    else
      render 'index'
    end
  end

	def destroy
		@user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end

  def user_params
    params.require(:user).permit(:id, :name, :email)
  end
end
