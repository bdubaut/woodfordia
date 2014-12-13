class CheckIn
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :scene

  field :outcome_scene_id,  type: String

  validates_presence_of :user, :scene
end
