class ScenesController < ApplicationController
  before_action :authenticate_user!

  def new
    @adventure = Adventure.where(id: params[:adventure_id]).first
    @list = Scene.where(:adventure => @adventure).entries.map{|s| [s.title, s.id]}
    @scene = Scene.new()
  end

  def create
    @adventure = Adventure.where(id: params[:adventure_id]).first
    unless @adventure.nil?
      s = Scene.new(scene_params)
      if s.save
        @adventure.scenes << s
        @adventure.save
        redirect_to adventures_path(params[:adventure_id]) and return
      else
        redirect_to new_adventure_scene_path, notice: "the scene could not be created" and return
      end
    end
    redirect_to(root_path, notice: "This adventure does not exist.") and return
  end

  def show
    adventure = Adventure.where(id: params[:adventure_id]).first
    @death = Scene.where(title: "Death", adventure: adventure).first
    @scene = Scene.where(adventure_id: params[:adventure_id], id: params[:id]).first
    redirect_to adventures_path(adventure.id) if @scene.nil?
  end

  def edit
    @adventure = Adventure.where(id: params[:adventure_id]).first
    redirect_to(root_path) and return if @adventure.nil?
    @scene = Scene.where(adventure_id: @adventure.id, id: params[:id]).first
    redirect_to(adventures_path(@adventure.id)) and return if @scene.nil?
  end

  def update
    adventure = Adventure.where(id: params[:adventure_id]).first
    redirect_to root_path and return if adventure.nil?
    scene = Scene.where(adventure_id: adventure.id, id: params[:id]).first
    redirect_to root_path and return if scene.nil?
    if scene.update_attributes(scene_params)
      redirect_to(adventure_scene_path(adventure.id, scene.id))
    # else
    #   redirect_to(edit_adventure_scene_path(adventure.id, scene.id))
    end
  end


  def destroy
    redirect_to root_path and return if Adventure.where(id: params[:adventure_id]).first.nil?
    scene = Scene.where(adventure_id: params[:adventure_id]).first
    redirect_to adventures_path(params[:adventure_id]), notice: "Scene not found" and return if scene.nil?
    if scene.delete
      notice = "Scene deleted"
    else
      notice = "a problem occured."
    end
    redirect_to adventures_path(params[:adventure_id]), notice: notice
  end

  private

  def scene_params
    params.require(:scene).permit(:title, :description, :question_1, :question_2, :question_3)
  end
end
