class ScenesController < ApplicationController
  before_action :authenticate_user!

  def new
    @adventure = Adventure.where(id: params[:adventure_id]).first
  end

  def create
    @adventure = Adventure.where(id: params[:adventure_id]).first
    unless @adventure.nil?
      s = Scene.new(scene_params)
      if s.save
        @adventure.scenes << s
        @adventure.save
        redirect_to adventure_path(params[:adventure_id]) and return
      else
        redirect_to new_adventure_scene_path, notice: "the scene could not be created" and return
      end
    end
    redirect_to(root_path, notice: "This adventure does not exist.") and return
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def scene_params
    params.require(:scene).permit(:title, :description)
  end
end
