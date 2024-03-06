# frozen_string_literal: true

class ReservationController < ApplicationController
  before_action :authorize_remote, only: [:import_from_remote]

  def import_from_remote
    Hostaway.new().import_reservation_from_resp(reservation_params)

    render json: {}
  end

  private

  def reservation_params
    params.permit(reservations: [:checkInTime, :checkOutTime, :totalPrice, :guestName, :status, :listingMapId])
  end
  def authorize_remote
    true
    #TODO: raise error if request authorization fails
  end
end
