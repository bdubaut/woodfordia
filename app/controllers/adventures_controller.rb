class AdventuresController < ApplicationController
  before_action :authenticate_user!

  def index
    @list = Adventure.all.entries
  end

  def create
    a = Adventure.new name: params[:adventure][:name], tagline: params[:adventure][:tagline], synopsis: params[:adventure][:synopsis]
    a.save ? redirect_to(root_path) : redirect_to(new_adventure_path)
  end

  def new
    @adventure = Adventure.new()
  end

  def edit
    @adventure = Adventure.where(:id => params[:id]).first
    render 'edit'
  end

  def update
    adventure = Adventure.where(:id => params[:id]).first
    if adventure.nil?
      redirect_to adventures_path
    else
      if adventure.update_attributes(adventure_params)
        redirect_to adventures_path(id: adventure.id)
      else
        redirect_to edit_adventures_path(id: adventure.id)
      end
    end
  end

  def show
    @adventure = Adventure.where(id: params[:id]).first
    @scenes = @adventure.scenes
  end

  def destroy
    if Adventure.where(id: params[:id]).delete
      redirect_to adventures_path
    else
      redirect_to adventures_path, notice: 'An error occured'
    end
  end

  private

  def adventure_params
    params.require(:adventure).permit(:name, :tagline, :synopsis)
  end
end
