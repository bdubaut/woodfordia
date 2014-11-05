require 'rails_helper'

RSpec.describe User, :type => :model do
  before(:each) do
    User.delete_all
  end
end
