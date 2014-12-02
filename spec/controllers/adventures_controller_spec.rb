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
      post :create, adventure: {name: "My new adventure"}
      expect(response).to redirect_to root_path
      expect(response.status).to eq 302
      expect(Adventure.count).to eq 1
      expect(Adventure.first.name).to eq "My new adventure"
    end
    it 'redirects to the new action if the adventure is not valid' do
      expect(Adventure.count).to eq 0
      post :create, adventure: {tagline: "an adventure without a name"}
      expect(Adventure.count).to eq 0
      expect(response).to redirect_to new_adventure_path
    end
  end
  describe '#show' do
    it 'returns the adventure' do
      a = FactoryGirl.create :adventure
      get :show, :id => a.id
      expect(response.status).to eq 200
      expect(assigns(:adventure)).to eq a
      expect(assigns(:scenes).size).to eq 1
      expect(response).to render_template(:show)
    end
  end

  describe '#update' do
    before(:each) do
      Adventure.delete_all
      @a = FactoryGirl.create :adventure
    end
    it 'updates the adventure' do
      expect(@a.name).to eq "The Legend of Zelda"
      put :update, id: @a.id, adventure: {name: "my new adventure"}
      @a.reload
      expect(@a.name).to eq "my new adventure"
    end
    it 'redirects to Adventures#index if the adventure is not found' do
      put :update, id: 'toto', adventure: {name: "my new adventure"}
      expect(response).to redirect_to adventures_path
    end
    it 'redirects to the show action on success' do
      put :update, id: @a.id, adventure: {name: "my new adventure", tagline: "a new hope", synopsis: 'toto'}
      expect(response).to redirect_to adventures_path(:id => @a.id)
    end
  end

  describe '#destroy' do
    before(:each) do
      Adventure.delete_all
      @a = FactoryGirl.create(:adventure)
    end
    it 'destroys the whole adventure.' do
      expect(Adventure.count).to eq 1
      delete :destroy, id: @a.id
      expect(Adventure.count).to eq 0
    end
    it 'redirects to index on success' do
      delete :destroy, id: 'toto'
      expect(response).to redirect_to adventures_path
    end
    it 'redirects to index on failure' do
      delete :destroy, id: 'toto'
      expect(response).to redirect_to adventures_path
    end
  end

  describe '#index' do
    before(:each) do
      Adventure.delete_all
      5.times { FactoryGirl.create(:adventure)}
    end
    it 'returns the list of adventures' do
      expect(Adventure.count).to eq 5
      get :index
      expect(assigns(:list).count).to eq 5
      expect(response).to render_template('index')
    end
  end

  describe '#edit' do
    before(:each) do
      Adventure.delete_all
      @a = FactoryGirl.create :adventure
    end
    it 'selects an adventure to edit' do
      get :edit, id: @a.id
      expect(assigns(:adventure)).to eq @a
    end
    it 'renders the edit view' do
      get :edit, id: @a.id
      expect(response).to render_template('edit')
    end
  end
end
