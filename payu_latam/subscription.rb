module PayuLatam
  class Subscription < Request
    attr_reader :url, :plan, :client, :card
    attr_accessor :resource, :params

    def initialize(plan, client, callback_url)
      @plan   = plan.resource
      @client = client
      @callback_url = callback_url
      @params = empty_object
      url
    end

    def url
      @url = PayuLatam.base_url + '/rest/v4.9/subscriptions/'
    end

    private

    def empty_object
      {
        "quantity": "1",
        "installments": "1",
        "immediatePayment": true,
        "customer": {
          "fullName": @client.resource['fullName'],
          "email": @client.resource['email'],
          "creditCards": @client.cards
        },
        "plan": {
          "planCode": @plan['planCode'],
          "maxPendingPayments": "1",
        },
        "notifyUrl": 'http://www.test.com/confirmation'
      }
    end
  end
end