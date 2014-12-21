require 'rails_helper'

RSpec.describe User, :type => :model do
  before(:each) do
    User.delete_all
  end

  describe '#user creation' do
    it 'should not be valid if first_name, last_name, password or email are blank' do
      u = User.new
      res = "can't be blank"
      list = "is not included in the list"
      u.valid?
      expect(u.errors.messages[:first_name]).to eq [res]
      expect(u.errors.messages[:last_name]).to eq [res]
    end
    it 'should assign the player role by default.' do
      u = User.create(first_name: "John", last_name: "Doe", email: "john@doe.com", password: "12345678", sex: 'M', age: 23)
      expect(u.has_role?(:player)).to be_truthy
    end
  end
end
