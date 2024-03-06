# frozen_string_literal: true
require 'uri'
require 'net/http'

module HstRequest

  def get_req(url, params = {})
    uri = URI(url)
    uri.query = URI.encode_www_form(params)
    [uri, Net::HTTP::Get.new(uri)]
  end

  def post_req(url, body = {})
    uri = URI(url)
    request = Net::HTTP::Post.new(uri)
    request.body = body

    [uri, request]
  end

  def make_request(uri, request)
    result = {}

    begin
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      # request['Authorization'] = 'Bearer your_access_token'
      request['Content-Type'] = 'application/json'
      # req = method == 'get' ? Net::HTTP::Get.new(uri) :  Net::HTTP::Post.new(uri)
      response_body = http.request(request).body
      result = response_body[:result]
      unless response.body[:status] == 'success'
        raise Net::HTTPBadResponse.new(result)
      end
    rescue Timeout::Error => e
      puts 'service timed out'
    rescue Errno::ECONNRESET => e
      puts 'Connection failed'
    rescue Net::HTTPHeaderSyntaxError => e
      puts 'Malformed headers'
    rescue Net::HTTPBadResponse => e
      puts 'Malformed params'
    ensure
      result
    end
  end
end
