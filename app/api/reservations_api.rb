# frozen_string_literal: true

class ReservationsAPI < ApplicationAPI
  resource :reservations do
    desc 'Create or Update'
    post do
      schema_hash = Reservations::SchemaIdentifier.new(params).call
      unless schema_hash
        Rails.logger.info("Undefined schema was used: #{params.keys}")
        error!('Undefined schema', 400)
      end

      reservation_hash = Reservations::Schema.new(schema_hash).parse_data(params)
      reservation_service = Reservations::CreateOrUpdate.new(reservation_hash)
      reservation = reservation_service.call
      unless reservation
        Rails.logger.error("Failed to process reservation. #{reservation_service.error_message}")
        error!("Unable to process reservation. #{reservation_service.error_message}", 422)
      end

      Rails.logger.info("Reservation processed: #{reservation.code}")
      send_success_message('Reservation successfully processed')
    end
  end
end
