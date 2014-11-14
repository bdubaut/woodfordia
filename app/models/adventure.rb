class Adventure
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :scenes

  field :name,      type: String
  field :tagline,   type: String
  field :synopsis,  type: String

  validates_presence_of :name
end
