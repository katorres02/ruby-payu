module PayuLatam
	class Subscription < Request
		attr_reader :url

		def url
			@url = PayuLatam.base_url + '/rest/v4.9/subscriptions/'
		end
	end
end