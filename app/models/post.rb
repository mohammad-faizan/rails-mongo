class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessor :picture

  field :author
  field :content
  has_many :comments
end
