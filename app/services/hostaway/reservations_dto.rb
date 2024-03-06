# frozen_string_literal: true

class ReservationsDTO
  def initialize(response)
    @response = response
  end

  def get_data
    @response['reservations'].map{|r| ReservationDTO.new(r).get_data }
  end

  def get_models
    @response['reservations'].map{ |r| ReservationDTO.new(r).get_model }
  end
end
