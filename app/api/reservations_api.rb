# frozen_string_literal: true

class ReservationsAPI < ApplicationAPI
  resource :reservations do
    desc 'Create'
    post do
      schema_hash = Reservations::SchemaIdentifier.new(params).call
      unless schema_hash
        # TODO: log it somewhere
        error!('Undefined schema', 400)
      end

      reservation_hash = Reservations::Schema.new(schema_hash).parse_data(params)
      create_service = Reservations::Create.new(reservation_hash)
      unless create_service.call
        # TODO: log it somewhere
        error!("Unable to create reservation: #{create_service.error_messages.join(', ')}", 500)
      end

      send_success_message('Reservation successfully created')
    end
  end
end
