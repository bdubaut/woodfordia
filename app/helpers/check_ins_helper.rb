module CheckInsHelper
  def scene_title id
    scene = Scene.where(id: id).first
    if scene.nil?
      return " "
    else
      scene.title
    end
  end
end
