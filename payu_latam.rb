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
require_relative 'payu_latam/subscription'


PayuLatam.configure do |x|
  x.api_login  = 'pRRXKOl8ikMmt9u'
  x.api_key    = '4Vj8eK4rloUd272L48hsrarnUA'
  x.account_id = '512321'
  x.sandbox   = true
end

# CLIENT CRUD

client = PayuLatam::Client.new
client.params = {fullName: 'Carlos', email: 'carlos@mail.com'}
client.create!
client.load(client.resource['id'])
#client.update({fullName: 'Carlos editado'})
#client.delete
puts "Cliente: "
p client.resource
puts ""

# PLAN CRUD

plan = PayuLatam::Plan.new
plan.create!
plan.load(plan.resource['planCode'])
#plan.update(description: 'test')
#plan.delete
puts "Plan: "
p plan.resource
puts ""

# CREDIT CARD CRUD
card = PayuLatam::Card.new(client)
card.create!
card.load(card.resource['token'])
puts "Card: "
p card.resource
puts ""

client.cards.push(card.resource)

# SUSCRIPTION CRUD
subscription = PayuLatam::Subscription.new(plan, client, '')

pry


