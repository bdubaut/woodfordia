require 'rails_helper'

RSpec.describe CheckIn, :type => :model do
  before(:each) do
    User.delete_all
    Scene.delete_all
    CheckIn.delete_all
  end
  describe 'validations' do
    before(:all) do
      User.delete_all
      @user = FactoryGirl.create(:player)
      @scene = FactoryGirl.create(:scene)
    end
    it 'should not be valid if there is no user' do
      c = CheckIn.new(scene: @scene.id)
      expect(c).not_to be_valid
    end
    it 'should not be valid if there is no user' do
      c = CheckIn.new(user: @user.id)
      expect(c).not_to be_valid
    end
  end
end
