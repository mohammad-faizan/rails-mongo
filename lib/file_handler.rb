class FileHandler

	attr_accessor :object

	def initialize(object)
		@object = object
	end

	def save
		fs = Mongoid.default_client.database.fs
    file = Mongo::Grid::File.new(object.picture.tempfile.read,
        filename: object.picture.original_filename,
        content_type: object.picture.content_type,
        chunk_size: 1024
      )
    id = fs.insert_one(file)
    fs.find_one(_id: id)
	end

	def update
	end
end