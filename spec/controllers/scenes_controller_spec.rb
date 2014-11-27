require 'rails_helper'

RSpec.describe ScenesController, :type => :controller do
  before(:all) do
    Adventure.delete_all
    Scene.delete_all
    User.delete_all
    Role.delete_all
    [:admin, :character, :player].each do |role|
      Role.find_or_create_by(name: role)
    end
    @user = FactoryGirl.create(:admin)
    @adventure = FactoryGirl.create(:adventure)
  end
  before(:each) do
    @adventure.scenes = [] and @adventure.save
    Scene.delete_all
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end
  describe '#create' do
    before(:each) do
      Scene.delete_all
    end
    it 'creates a new scene in the adventure' do
      expect(@adventure.scenes).to be_empty
      post :create, adventure_id: @adventure.id, scene: {title: 'Scene 01', description: 'blabla'}
      expect(@adventure.scenes.count).to eq 1
      expect(response.status).to eq 302
      expect(response).to redirect_to adventures_path(@adventure.id)
    end
    it 'redirects to the dashboard if the adventure is not found' do
      post :create, adventure_id: "toto", scene: {title: 'Scene 01', description: 'blabla'}
      expect(response).to redirect_to root_path
    end
    it 'redirects to the new action if the creation fails.' do
      expect(@adventure.scenes).to be_empty
      post :create, adventure_id: @adventure.id, scene: {description: 'blabla'}
      expect(response).to redirect_to new_adventure_scene_path(adventure_id: @adventure.id)
    end
  end
  describe '#new' do
    it 'selects an adventure and renders the new action template' do
      get :new, adventure_id: @adventure.id
      expect(assigns(:adventure)).to eq @adventure
      expect(response).to render_template('new')
    end
  end
  describe '#edit' do
    before(:each) do
      Scene.delete_all
    end
    it 'renders the edit view and assigns adventure and scene' do
      scene = FactoryGirl.create(:scene, adventure: @adventure)
      get :edit, adventure_id: @adventure.id, id: scene.id
      expect(assigns(:adventure)).to eq @adventure
      expect(assigns(:scene)).to eq scene
      expect(response).to render_template('edit')
    end
    it 'redirects to the adventure page if the scene is not found' do
      get :edit, adventure_id: @adventure.id, id: 'Momo'
      expect(response).to redirect_to(adventures_path(@adventure.id))
    end
    it 'redirects to the dashboard if the adventure is not found' do
      get :edit, adventure_id: 'bobby', id: 'Momo'
      expect(response).to redirect_to(root_path)
    end
  end
  describe '#update' do
    it 'updates the given scene' do
      scene = FactoryGirl.create(:scene, adventure: @adventure)
      put :update, adventure_id: @adventure.id, id: scene.id, scene: {title: "New title", description: "gologolo"}
      scene.reload
      expect(scene.title).to eq "New title"
      expect(scene.description).to eq "gologolo"
    end
    # it 'redirects to the edit action in case of failure' do
    #   scene = FactoryGirl.create(:scene, adventure: @adventure)
    #   put :update, adventure_id: @adventure.id, id: scene.id, scene: {title: {}}
    #   expect(response).to redirect_to(edit_adventure_scene_path(@adventure.id, scene.id))
    # end
    it 'redirects to the show action in case of success' do
      scene = FactoryGirl.create(:scene, adventure: @adventure)
      put :update, adventure_id: @adventure.id, id: scene.id, scene: {title: "New title", description: "gologolo"}
      expect(response).to redirect_to adventure_scene_path(@adventure.id, scene.id)
    end
    it 'redirects to root_path if the scene is not found' do
      scene = FactoryGirl.create(:scene, adventure: @adventure)
      put :update, adventure_id: @adventure.id, id: 'toto', scene: {title: "New title"}
      expect(response).to redirect_to root_path
    end
    it 'redirects to root_path if the adventure is not found' do
      scene = FactoryGirl.create(:scene, adventure: @adventure)
      put :update, adventure_id: 'toto', id: 'toto', scene: {title: "New title"}
      expect(response).to redirect_to root_path
    end
  end
  describe '#show' do
    it 'shows the scene' do
      scene = FactoryGirl.create(:scene, adventure: @adventure)
      get :show, adventure_id: @adventure.id, id: scene.id
      expect(assigns(:scene)).to eq scene
      expect(response).to render_template('show')
    end
    it 'redirects to the adventure if the scene is not found' do
      get :show, adventure_id: @adventure.id, id: 'toto'
      expect(response).to redirect_to adventures_path(@adventure.id)
    end
  end
  describe '#destroy' do
    it 'deletes the given scene from the adventure.' do
      scene = FactoryGirl.create(:scene, adventure: @adventure)
      expect(@adventure.scenes.count).to eq 1
      delete :destroy, adventure_id: @adventure.id, id: scene.id
      @adventure.reload
      expect(@adventure.scenes).to be_empty
    end
    it 'redirects to the adventure if the deletion fails' do
      scene = FactoryGirl.create(:scene, adventure: @adventure)
      allow(scene).to receive(:delete).and_return(false)
      delete :destroy, adventure_id: @adventure.id, id: scene.id
      expect(response).to redirect_to adventures_path(@adventure.id)
    end
    it 'redirects to the adventure if the scene is not found' do
      scene = FactoryGirl.create(:scene, adventure: @adventure)
      delete :destroy, adventure_id: @adventure.id, id: scene.id
      expect(response).to redirect_to adventures_path(@adventure.id)
    end
    it 'redirects to root path if the adventure is not found' do
      scene = FactoryGirl.create(:scene, adventure: @adventure)
      delete :destroy, adventure_id: 'toto', id: scene.id
      expect(response).to redirect_to root_path
    end
  end
end
