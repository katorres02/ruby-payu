module PayuLatam
	class Card < Request
		attr_reader :url, :customer_url, :customer

		def initialize(customer={})
			@customer = customer
		end

		def customer
			@customer ||= { id: nil }
		end

		def url
			@url = PayuLatam.base_url + "/rest/v4.9/creditCard/"
		end

		def customer_url
			@url = PayuLatam.base_url + "/rest/v4.9/customers/#{@customer[:id]}/creditCard/"
		end
	end
end