class CheckIn
  include Mongoid::Document
  include Mongoid::Timestamps

  has_one :user
  has_one :scene

  validates_presence_of :user, :scene
end
