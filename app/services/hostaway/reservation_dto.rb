# frozen_string_literal: true

class ReservationDTO
  def initialize(response)
    @response = response
  end

  def get_data
    {
      check_in: @response['checkInTime'],
      check_out: @response['checkOutTime'],
      price: @response['totalPrice'],
      guest_name: @response['guestName'],
      status: @response['status'],
      listing_id: @response['listingMapId']
    }
  end

  def get_model
    Reservation.new(get_data)
  end
end
