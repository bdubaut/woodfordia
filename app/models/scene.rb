class Scene
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :check_ins
  belongs_to :adventure

  field :title,       type: String
  field :description, type: String

  validates_presence_of :title
end
