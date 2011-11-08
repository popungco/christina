class Image
  include Mongoid::Document
  field :content
  mount_uploader :attach, ImageUploader, :required => true
  belongs_to :post
  validates_presence_of :attach, :content
end
