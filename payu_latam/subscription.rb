module PayuLatam
  class Subscription < Request
    attr_reader :url, :plan, :client, :callback_url
    attr_accessor :resource, :params

    def initialize(plan, client, callback_url)
      @plan = plan
      @client = client
      @callback_url = callback_url || ''
      @params = empty_object
    end

    def url
      @url = PayuLatam.base_url + '/rest/v4.9/subscriptions/'
    end

    private

    def empty_object
      {
        "quantity": "1",
        "installments": "1",
        "trialDays": "0",
        "immediatePayment": true,
        "customer": {
          "fullName": @client.resource['fullName'],
          "email": @client.resource['email'],
          "creditCards": @client.cards
        },
        "plan": @plan.resource,
        "notifyUrl": @callback_url
      }
    end
  end
end