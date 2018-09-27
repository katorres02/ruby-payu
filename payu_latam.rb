module PayuLatam
  require "base64"

  class << self
    attr_accessor :api_login, :api_key, :account_id, :sandbox
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
  x.api_login  = 'pRRXKOl8ikMmt9u'
  x.api_key    = '4Vj8eK4rloUd272L48hsrarnUA'
  x.account_id = '512321'
  x.sandbox   = true
end

# CLIENT CRUD
=begin
client = PayuLatam::Client.new
client.params = {fullName: 'Carlos', email: 'carlos@mail.com'}
client.create!
client.load(client.resource['id'])
client.update({fullName: 'Carlos editado'})
client.delete
client.resource
=end

# PLAN CRUD
=begin
plan = PayuLatam::Plan.new
plan.create!
plan.load(plan.resource['planCode'])
plan.update(description: 'test')
plan.delete
plan.resource
=end

pry



