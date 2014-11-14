require 'rails_helper'

RSpec.describe AdventuresController, :type => :controller do
  before(:all) do
    Role.delete_all
    [:admin, :character, :player].each do |role|
      Role.find_or_create_by(name: role)
    end
  end
  before(:each) do
    Adventure.delete_all
    User.delete_all
    allow(controller).to receive(:authenticate_user!).and_return(true)
  end
  describe '#create' do
    it 'creates a new Adventure' do
      expect(Adventure.count).to eq 0
      post :create, name: "My new adventure"
      expect(response).to redirect_to root_path
      expect(response.status).to eq 302
      expect(Adventure.count).to eq 1
      expect(Adventure.first.name).to eq "My new adventure"
    end
    it 'redirects to the new action if the adventure is not valid' do
      expect(Adventure.count).to eq 0
      post :create, tagline: "an adventure without a name"
      expect(Adventure.count).to eq 0
      expect(response).to redirect_to new_adventure_path
    end
  end
  describe '#show' do
    it 'returns the adventure' do
      a = FactoryGirl.create :adventure
      get :show, :id => a.id
      expect(response.status).to eq 200
      expect(response).to render_template(:show)
    end
  end

  describe '#update' do
    it 'updates the adventure' do

    end

    it 'redirects to the show action on success' do

    end

    it 'redirects to the edit action on failure' do

    end
  end

end
