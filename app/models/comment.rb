class Comment
  include Mongoid::Document
  field :name
  field :content
  embedded_in :post, :inverse_of => :comments
end
