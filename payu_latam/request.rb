require 'uri'
require 'net/https'
require 'json'

module PayuLatam
  class Request
    attr_accessor :url, :_url, :params
    attr_reader :response, :http_verb, :error

    def create!
      @http_verb = 'Post'
      http
      @resource = @response if @response
    end

    def update(params={})
      @http_verb = 'Put'
      @url += id.to_s

      @params = params if !params.empty?
      @params.merge!({id: id}) if id

      http
      @resource = @response if @response
    end

    def load(id)
      @http_verb = 'Get'
      @url += id.to_s
      http
      @resource = @response if @response
    end

    def delete
      @http_verb = 'Delete'
      @url += id.to_s
      http
      @resource = nil if @response
    end

    def success?
      @error.nil?
    end

    def fail?
      !@error.nil?
    end

    def id
      raise ArgumentError, 'customer is nil' if @resource.nil?
      @resource['id'] if @resource
    end

    private

    def url
      @url ||= _url
    end

    def reset_url
      @url = url
    end

    def http
      puts "#{http_verb} #{@url}"
      uri = URI.parse(@url)
      https = Net::HTTP.new(uri.host,uri.port)
      
      https.use_ssl = true
      https.verify_mode = OpenSSL::SSL::VERIFY_NONE
      
      net_class = Object.const_get("Net::HTTP::#{http_verb}")
      request = net_class.new(uri.path, initheader = {'Content-Type' =>'application/json'})
      
      request['Accept'] = 'application/json'
      request['Accept-language'] = 'es'
      request['Authorization']   = PayuLatam.authorization

      request.body = @params.to_json
      request = https.request(request)
      
      reset_url
      
      if request.is_a?(Net::HTTPSuccess)
        begin
          @response = JSON.parse(request.body)
        rescue
          @response = request.body
        end
        @error = nil
      else
        @response = nil
        @error = JSON.parse(request.body)
      end
    end
  end
end