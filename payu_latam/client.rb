module PayuLatam
  class Client < Request
    attr_reader :url
    attr_accessor :resource, :params

    # in order to take the correct url
    def initialize(id=nil)
      url
      @params = empty_object
      return if id.nil?
      load(id)
    end

    def empty_object
      { 'fullName'=> '', 'email'=> '' }
    end

    def url
      @url = PayuLatam.base_url + '/rest/v4.9/customers/'
    end
  end
end