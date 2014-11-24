class CheckIn
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :scene

  field :answer_1,          type: String
  field :answer_2,          type: String
  field :answer_3,          type: String
  field :outcome_scene_id,  type: String

  validates_presence_of :user, :scene
end
