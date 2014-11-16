class CheckIn
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :scene

  validates_presence_of :user, :scene
end
