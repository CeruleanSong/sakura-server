module Source
	def self.create(source_id)
		Mangahere.new(source_id)
	end

	class Mangahere
		def initialize(source_id)
			@origin = 'http://www.mangahere.cc'
			@title = 'mangahere'
			@alias = 'mangahere'
			@enabled = false
			@source_id = source_id
		end
		
		def getOrigin
			return @origin
		end
		
		def getTitle
			return @title
		end
		
		def getAlias
			return @alias
		end

		def isEnabled
			return @enabled
		end
	end
end