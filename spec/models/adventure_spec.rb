require 'rails_helper'

RSpec.describe Adventure, :type => :model do
  it 'cannot be valid if name is blank' do
    a = Adventure.new
    expect(a).not_to be_valid
    a.name = ""
    expect(a).not_to be_valid
  end
end
