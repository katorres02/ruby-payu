module PayuLatam
  class Client < Request
    attr_reader :url, :card
    attr_accessor :resource, :params, :cards

    # in order to take the correct url
    def initialize(id=nil)
      url
      @params = empty_object
      @cards  = []
      return if id.nil?
      load(id)
    end

    def card
      @card ||= Card.new(self.resource)
    end

    def url
      @url = PayuLatam.base_url + '/rest/v4.9/customers/'
    end

    private

    def empty_object
      { 'fullName'=> '', 'email'=> '' }
    end
  end
end