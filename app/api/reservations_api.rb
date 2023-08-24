# frozen_string_literal: true

class ReservationsAPI < ApplicationAPI
  resource :reservations do
    desc 'Create or Update'
    post do
      schema_hash = Reservations::SchemaIdentifier.new(params).call
      unless schema_hash
        # TODO: log it somewhere
        error!('Undefined schema', 400)
      end

      reservation_hash = Reservations::Schema.new(schema_hash).parse_data(params)
      reservation_service = Reservations::CreateOrUpdate.new(reservation_hash)
      unless reservation_service.call
        # TODO: log it somewhere
        error!("Unable to process reservation. #{reservation_service.error_message}", 422)
      end

      send_success_message('Reservation successfully processed')
    end
  end
end
