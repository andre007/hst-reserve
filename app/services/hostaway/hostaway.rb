# frozen_string_literal: true
require 'uri'
require 'net/http'

class Hostaway
  include Authorizer

  def get_reservations_list(params={})
    uri, req = get_req('https://api.hostaway.com/v1/reservations', params)
    plain_response = handle_authorized_request(uri, req)

    ReservationsDTO.new(plain_response)
  end

  def get_plain_reservations_list(params={})
    uri, req = get_req('https://api.hostaway.com/v1/reservations', params)
    handle_authorized_request(uri, req)
  end

  def import_reservation_list(filter = {})
    plain_response = get_plain_reservations_list(filter)
    import_reservation_from_resp(plain_response)
  end

  def import_reservation_last_two_weeks
    import_reservation_list({ arrivalStart: 2.weeks.ago.to_s })
  end

  def import_reservation_from_resp(plain_response)
    reservations = ReservationsDTO.new(plain_response).get_models
    Reservation.import(reservations)
  end
end
