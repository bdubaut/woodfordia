require 'rails_helper'

RSpec.describe User, :type => :model do
  before(:each) do
    User.delete_all
  end

  describe '#user creation' do
    it 'should not be valid if first_name, last_name, password or email are blank' do
      u = User.new
      res = "can't be blank"
      u.valid?
      u.errors.messages.each_value do |v|
        expect(v).to eq [res]
      end
    end
    it 'should assign the player role by default.' do
      u = User.create(first_name: "John", last_name: "Doe", email: "john@doe.com", password: "12345678")
      expect(u.has_role?(:player)).to be_truthy
    end
  end
end
