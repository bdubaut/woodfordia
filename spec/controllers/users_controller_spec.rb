require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  before(:each) do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    User.delete_all
  end
  describe '#index' do
    it 'returns the list of all the users' do
      FactoryGirl.create(:player)
      get :index
      expect(assigns(:list).size).to eq 1
    end
  end
  describe '#new' do
    it 'instanciates a new user for Form purposes' do
      get :new
      expect(assigns(:user).class).to eq User.new.class
    end
  end
  describe 'create' do
    it 'creates a new player with the specified role' do
      u = FactoryGirl.build(:character)
      post :create, user: {first_name: 'Johnny', last_name: 'Fields', character_name: 'Coockie monster', password: u.password, role: 'character', email: 'me@toto.fr'}
      expect(User.count).to eq 1
      expect(User.last.first_name).to eq 'Johnny'
      expect(User.last.has_role?(:character)).to be_truthy
      expect(response).to redirect_to users_path
    end
  end
end
