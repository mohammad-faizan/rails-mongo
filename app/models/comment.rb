class Comment
	include Mongoid::Document
	include Mongoid::Timestamps
	field :name
	field :comment
	belongs_to :post
end