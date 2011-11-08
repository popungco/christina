class Post
  
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes
  field :subject
  field :published_on, :type => Time
  
  has_many :images, :autosave => true
  embeds_many :comments
  
  validates_presence_of :subject

  #validates :subject, :images, :presence => true
  accepts_nested_attributes_for :images, :allow_destroy => true
  
end
