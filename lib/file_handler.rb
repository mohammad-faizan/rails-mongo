class FileHandler

	attr_accessor :object, :stream

	def initialize(object, stream)
		@object = object
		@stream = stream
	end

	def save
		begin
			fs = Mongoid.default_client.database.fs
	    file = Mongo::Grid::File.new(stream.tempfile.read,
	        filename: stream.original_filename,
	        content_type: stream.content_type,
	        chunk_size: 2048
	      )
	    self.object.create_picture(file_id: fs.insert_one(file))
		rescue Exception => e
			puts e.message
		end
	end

	def update
	end
end