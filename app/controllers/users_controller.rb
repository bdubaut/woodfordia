class UsersController < ApplicationController
  def index
    @list = User.all.entries
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.add_role(params[:user][:role].to_sym)
      @user.save
    else
      redirect_to(new_user_path) and return
    end
    redirect_to(users_path) and return
  end

  def show
    @user = User.where(id: params[:id]).first
  end

  def destroy
    @user = User.where(id: params[:id]).first
    @user.delete
    redirect_to users_path
  end

  def edit
    @user = User.where(id: params[:id]).first
  end

  def update
    
  end

  private
  def user_params
    params.require(:user).permit(:character_name, :first_name, :last_name, :email, :password)
  end
end
