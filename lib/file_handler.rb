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
	    file_id = fs.insert_one(file)
	    type = stream.original_filename.split('.').last

	    path = "public/images/#{object.class}/#{object.id}/"
	    asset_path = "/images/#{object.class}/#{object.id}/"

	    original = path + "original/"
	    one100 = path + "one100/"
	    one64 = path + "one64/"
	    one80 = path + "one80/"

	    FileUtils::mkdir_p path unless File.directory?(path)
	    FileUtils::mkdir_p original unless File.directory?(original)
	    FileUtils::mkdir_p one100 unless File.directory?(one100)
	    FileUtils::mkdir_p one64 unless File.directory?(one64)
	    FileUtils::mkdir_p one80 unless File.directory?(one80)
	    
	    original = original + "#{stream.original_filename}"
	    one100 = one100 + "#{stream.original_filename}"
	    one64 = one64 + "#{stream.original_filename}"
	    one80 = one80 + "#{stream.original_filename}"

	    original_asset = asset_path + "original/#{stream.original_filename}"
	    one100_asset = asset_path + "one100/#{stream.original_filename}"
	    one64_asset = asset_path + "one64/#{stream.original_filename}"
	    one80_asset = asset_path + "one80/#{stream.original_filename}"

	    image = MiniMagick::Image.read(stream.tempfile)
	    image.write(original) # Save original
	    Rails.logger.debug "Saved original image to #{original}"

	    # Create 100x100
	    image = MiniMagick::Image.open(original)
	    image.resize '100x100'
	    image.write(one100)
	    Rails.logger.debug "Saved 100x100 image to #{one100}"

	    # Create 164x164
	    image = MiniMagick::Image.open(original)
	    image.resize '164x164'
	    image.write(one64)
	    Rails.logger.debug "Saved 164x164 image to #{one64}"

	    # Create 180x180
	    image = MiniMagick::Image.open(original)
	    image.resize '180x180'
	    image.write(one80)
	    Rails.logger.debug "Saved 180x180 image to #{one80}"

	    self.object.create_picture(file_id: file_id,
	    		original: original_asset,
	    		path100: one100_asset,
	    		path164: one64_asset,
	    		path180: one80_asset
	    	)
		rescue Exception => e
			puts e.message
		end
	end

	def update
	end
end