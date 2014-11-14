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
      expect(response).to redirect_to adventure_path(@adventure.id)
    end
    it 'redirects to the dashboard if the adventure is not found' do
      post :create, adventure_id: "toto", scene: {title: 'Scene 01', description: 'blabla'}
      expect(response).to redirect_to root_path
    end
    it 'redirects to the new action if the creation fails.' do
      expect(@adventure.scenes).to be_empty
      post :create, adventure_id: @adventure.id, scene: {description: 'blabla'}
      expect(response).to redirect_to new_adventure_scene_path(adventure_id: @adventure_id)
    end
  end
end
