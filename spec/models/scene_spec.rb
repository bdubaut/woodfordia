require 'rails_helper'

RSpec.describe Scene, :type => :model do
  it 'cannot be valid if name is blank' do
    s = Scene.new
    expect(s).not_to be_valid
    s.title = ""
    expect(s).not_to be_valid
  end
end
