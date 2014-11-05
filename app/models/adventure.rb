class Adventure
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,      type: String
  field :tagline,   type: String
  field :synopsis,  type: String

  validates_presence_of :name
end
