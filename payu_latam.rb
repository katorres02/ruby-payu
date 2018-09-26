module PayuLatam
	require "base64"

	class << self
		attr_accessor :api_login, :api_key, :sandbox
		attr_reader   :base_url
		
		def configure(&block)
    	block.call(self)
  	end

  	def base_url
  		if PayuLatam.sandbox
				@base_url = 'https://sandbox.api.payulatam.com/payments-api'
			else
				@base_url = 'https://api.payulatam.com/payments-api'
			end
  	end

  	def authorization
  		@authorization ||= "Basic " + Base64.strict_encode64("#{api_login}:#{api_key}").to_s
  	end
	end
end

require 'pry'
require_relative 'payu_latam/request'
require_relative 'payu_latam/plan'
require_relative 'payu_latam/client'
require_relative 'payu_latam/card'


PayuLatam.configure do |x|
	x.api_login = 'pRRXKOl8ikMmt9u'
	x.api_key   = '4Vj8eK4rloUd272L48hsrarnUA'
	#x.api_login = 'M5xsYdg0Eqy7G8E'
	#x.api_key   = '33PQf6l0o8RWHC1hgxmMs6WWkZ'
	x.sandbox   = true
end

#merchant_id = 758556

client = PayuLatam::Client.new
#{fullName: 'Carlos', email: 'carlos@mail.com'}
p client.url
puts a = "#{PayuLatam.api_login}:#{PayuLatam.api_key}"
puts PayuLatam.authorization
puts ""

#client.create
client = PayuLatam::Client.new('b4bd65e1fqjf')
p client.response
pry
client.show(client.response['id'])




