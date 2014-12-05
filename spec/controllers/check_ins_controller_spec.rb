require 'rails_helper'

RSpec.describe CheckInsController, :type => :controller do
  before(:all) do
    User.delete_all
    Role.delete_all
    [:admin, :character, :player].each do |role|
      Role.find_or_create_by(name: role)
    end
    @user = FactoryGirl.create(:admin)
    @user.remove_role :player
    @player = FactoryGirl.create(:player)
    @adventure = FactoryGirl.create(:adventure)
    @scene = FactoryGirl.create(:scene, adventure: @adventure)
  end
  after(:all) do
    User.delete_all
  end
  before(:each) do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    CheckIn.delete_all
  end
  describe '#new' do
    it 'sets up the params for the new check in' do
      get :new, adventure_id: @adventure.id, scene_id: @scene.id
      expect(assigns(:adventure)).to eq @adventure
      expect(assigns(:scene)).to eq @scene
      expect(assigns(:users).count).to eq 1
    end
  end
  describe '#create' do
    it 'checks in a player in a scene' do
      expect(CheckIn.count).to eq 0
      post :create,  check_in: { adventure_id: @adventure.id, scene_id: @scene.id, user_id: @player.id}
      expect(CheckIn.count).to eq 1
    end
    it 'redirects to the scene' do
      post :create,  check_in: {adventure_id: @adventure.id, scene_id: @scene.id, user_id: @player.id}
      expect(response).to redirect_to adventure_scene_path(adventure_id: @adventure.id, id: @scene.id)
    end
  end
  describe '#destroy' do
    before(:each) do
      CheckIn.delete_all
      @c = CheckIn.create(user: @player, scene: @scene)
    end
    it 'deletes a check_in' do
      expect(CheckIn.count).to eq 1
      delete :destroy, id: @c.id
      expect(CheckIn.count).to eq 0
      expect(response).to redirect_to adventure_scene_path(adventure_id: @scene.adventure.id, id: @scene.id)
    end
    it 'redirects to the scene in case of failure' do
      allow(@c).to receive(:delete).and_return(false)
      delete :destroy, id: @c.id
      expect(response).to redirect_to adventure_scene_path(adventure_id: @scene.adventure.id, id: @scene.id)
    end
  end
end
