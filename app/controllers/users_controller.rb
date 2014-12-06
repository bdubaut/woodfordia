class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @list = User.all.entries
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.add_role(params[:user][:roles].to_sym)
      @user.save
    else
      raise @user.errors.inspect
      redirect_to(new_admin_user_path) and return
    end
    redirect_to(admin_users_path) and return
  end

  def show
    @user = User.where(id: params[:id]).first
  end

  def destroy
    @user = User.where(id: params[:id]).first
    @user.delete
    redirect_to admin_users_path
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
