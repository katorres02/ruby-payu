module PayuLatam
  class Plan < Request
    attr_reader :url
    attr_accessor :resource, :params
    
    # in order to take the correct url
    def initialize(id=nil)
      url
      @params = empty_object
      return if id.nil?
      load(id)
    end

    def update(params={})
      @http_verb = 'Put'
      @url += id.to_s

      @params = params if !params.empty?
      http
      @resource = @response if @response
    end

    # override from request
    def id
      raise ArgumentError, 'plan is nil' if @resource.nil?
      @resource['planCode'] if @resource
    end

    def url
      @url = PayuLatam.base_url + '/rest/v4.9/plans/'
    end

    private

    def empty_object
      {
        "accountId": PayuLatam.account_id,
        "planCode": "carlos-plan#{Time.now.to_i}",
        "description": "Suscripción Utopicko",
        "interval": "MONTH",#MONTH
        "intervalCount": "1",
        "maxPaymentsAllowed": "12",
        "paymentAttemptsDelay": "1",
        "additionalValues": [
          {
            "name": "PLAN_VALUE",
            "value": "20000",
            "currency": "COP"
          }
        ]
      }
    end
  end
end