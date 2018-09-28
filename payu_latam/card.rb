module PayuLatam
  class Card < Request
    attr_reader :url, :customer_url, :customer
    attr_accessor :resource, :params

    def initialize(customer={})
      url
      @params   = empty_object
      @customer = customer.resource if !customer.nil?
      return if @resource.nil?
      load(id)
    end

    def customer
      @customer ||= { id: nil }
    end

    def url
      @url ||= PayuLatam.base_url + "/rest/v4.9/creditCards/"
    end

    def customer_url
      @url = PayuLatam.base_url + "/rest/v4.9/customers/#{@customer['id']}/creditCards/"
    end

    def create!
      customer_url
      super
    end

    def load(id)
      reset_url
      super
    end

    def delete
      customer_url
      super
    end

    def update(params={})
      reset_url
      @http_verb = 'Put'
      @url += id.to_s
      @params = params if !params.empty?
      http
      @resource = @response if @response
    end

    # override from request
    def id
      raise ArgumentError, 'Card is nil' if @resource.nil?
      @resource['token'] if @resource
    end

    private

    def reset_url
      @url = PayuLatam.base_url + "/rest/v4.9/creditCards/"
    end

    def empty_object
      {
        "name": "Sample User Name",
        "document": "1020304050",
        "number": "4242434242424242",
        "expMonth": "01",
        "expYear": "2020",
        "type": "VISA",
        "address": {
          "line1": "Address Name",
          "line2": "17 25",
          "line3": "Of 301",
          "postalCode": "00000",
          "city": "City Name",
          "state": "State Name",
          "country": "CO",
          "phone": "300300300"
        }
      }
    end
  end
end