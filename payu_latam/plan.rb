module PayuLatam
	class Plan < Request
		attr_reader :url
		attr_accessor :resource, :params
		
		# in order to take the correct url
		def initialize(id=nil)
			url
			return if id.nil?
			load(id)
		end

		def url
			@url = PayuLatam.base_url + '/rest/v4.9/plans/'
		end
	end
end