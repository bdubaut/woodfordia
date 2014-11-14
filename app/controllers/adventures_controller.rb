class AdventuresController < ApplicationController
  before_action :authenticate_user!

  def create
    a = Adventure.new name: params[:name], tagline: params[:tagline], synopsis: params[:synopsis]
    a.save ? redirect_to(root_path) : redirect_to(new_adventure_path)
  end

  def new
  end

  def edit

  end

  def update

  end

  def show
    @adventure = Adventure.where(id: params[:id]).first
  end

  def destroy

  end
end
