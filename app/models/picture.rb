class Picture
	include Mongoid::Document
	embedded_in :post

	field :file_id, type: BSON::ObjectId

	def image
		build_image_file
	end

	def build_image_file
		data_file
	end

	def data_file
		file = Mongoid.default_client.database.fs.find_one(_id: self.file_id)
	end
end