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
  end
  describe '#create' do
    it 'creates a new Adventure' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      admin = FactoryGirl.create(:admin)
      admin.add_role(:admin)
      sign_in admin
      expect(Adventure.count).to eq 0
      post :create, name: "My new adventure"
      expect(response).to redirect_to root_path
      expect(response.status).to eq 302
      expect(Adventure.count).to eq 1
      expect(Adventure.first.name).to eq "My new adventure"
    end
    it 'redirects to the new action if the adventure is not valid' do
      admin = FactoryGirl.create(:admin)
      admin.add_role(:admin)
      sign_in admin
      expect(Adventure.count).to eq 0
      post :create, tagline: "an adventure without a name"
      expect(Adventure.count).to eq 0
      expect(response).to redirect_to new_adventure_path
    end
  end

end
