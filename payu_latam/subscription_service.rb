module PayuLatam
	class SubscriptionService
		attr_reader :user_id

		def initialize(user_id)
			@user_id = user_id
		end
		
	end
end