class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  field :author
  field :content
  has_many :comments
  embeds_one :picture
end
