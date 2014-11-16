class CheckInsController < ApplicationController
  before_action :authenticate_user!

  def new
    @adventure = Adventure.where(id: params[:adventure_id]).first
    @scene = Scene.where(adventure_id: params[:adventure_id], id: params[:scene_id]).first
    @users = User.with_role(:player).entries
  end

  def create
    @check_in = CheckIn.create(check_in_params)
    redirect_to adventure_scene_path(adventure_id: params[:adventure_id], id: params[:check_in][:scene_id]) and return if @check_in.nil?
    redirect_to adventure_scene_path(adventure_id: params[:adventure_id], id: params[:check_in][:scene_id])
  end

  def destroy
    c = CheckIn.where(id: params[:id]).first
    scene = c.scene
    c.delete ? notice = "Check in deleted successfully." : notice = "An error occured"
    redirect_to adventure_scene_path(adventure_id: scene.adventure.id, id: scene.id), notice: notice
  end

  private

  def check_in_params
    params.require(:check_in).permit(:user_id, :scene_id)
  end
end
