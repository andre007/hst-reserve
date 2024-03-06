# frozen_string_literal: true
require 'uri'
require 'net/http'
module Authorizer
  include HstRequest

  def authorize!(request)
    if @token_data && @token_data[:expires_at] > Time.current.to_i
      return request
    end

    uri, req = post_req('https://api.hostaway.com/v1/accessTokens', {
      grant_type: 'client_credentials',
      client_id:  Rails.application.secrets.client_id,
      client_secret: Rails.application.secrets.client_secret,
      scope: 'general'
    })
    @token_data = make_request(uri, req)
    request['Authorization'] = @token_data[:access_token]
    request
  end

  def handle_authorized_request(uri, req)
    authorize!(req)
    make_request(uri, req)
  end
end
