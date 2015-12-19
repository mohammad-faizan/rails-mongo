class Picture
	include Mongoid::Document
	embedded_in :post

	field :file_id, type: BSON::ObjectId
	field :original, type: String
	field :path100, type: String
	field :path164, type: String
	field :path180, type: String

	def url
		"#{Rails.root}" + self.path
	end

	def [](key)
		m = key.to_s.strip
		if respond_to?(m)
			return self.send(key.to_s.strip)
		else
			return ''
		end
	end

end