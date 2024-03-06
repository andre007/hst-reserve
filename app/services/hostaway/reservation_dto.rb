# frozen_string_literal: true

class ReservationDTO
  def initialize(response)
    @response = response
  end

  def get_value
    {
      check_in: @response['checkInTime'],
      check_out: @response['checkOutTime'],
      price: @response['totalPrice'],
      guest_name: @response['guestName'],
      status: @response['status'],
      listing_id: @response['listingMapId']
    }
  end
end
