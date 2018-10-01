module PayuLatam
  class Client < Request
    attr_reader :url, :cards
    attr_accessor :resource, :params

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

    # respuesta de creación de tarjetas de tipo {"token"=>"381e8708-b46e-4f1a-adb2-a0ac4a2ae099"}
    def add_card(card)
      @cards.push(card)
    end

    private

    def empty_object
      { 'fullName'=> '', 'email'=> '' }
    end
  end
end