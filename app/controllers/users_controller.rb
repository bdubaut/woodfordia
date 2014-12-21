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
    @user.password = 'password'
    if @user.valid?
      if params[:user][:first_time] == "1"
        @user.first_time = true
      elsif params[:user][:first_time] == "0"
        @user.first_time = false
      end
      @user.add_role(params[:user][:roles].to_sym)
      @user.save
    else
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
    @user = User.where(id: params[:id]).first
    redirect_to root_path and return if @user.nil?
    if @user.update_attributes(user_params)
      if params[:user][:first_time] == "1"
        @user.first_time = true
      elsif params[:user][:first_time] == "0"
        @user.first_time = false
      end
      @user.roles = []
      @user.add_role(params[:user][:roles].to_sym)
      @user.save ? (redirect_to(admin_users_path) and return) : (redirect_to(admin_users_path, notice: 'An Error occured ') and return)
    else
      redirect_to(admin_users_path, notice: 'An Error occured ') and return
    end
  end

  private
  def user_params
    params.require(:user).permit(:character_name, :first_name, :last_name, :email, :sex, :age, :first_time?)
  end
end
