# frozen_string_literal: true

module Reservations
  class Create
    attr_reader :error_message

    def initialize(reservation_hash)
      @reservation_params = reservation_hash.except('guest_params')
      @guest_params = reservation_hash['guest_params']
      @error_message = nil
    end

    def call
      ActiveRecord::Base.transaction do
        guest_record = guest
        reservation = Reservation.new(reservation_params.merge(guest_id: guest_record.id))
        reservation.save!
      end
      true
    rescue ActiveRecord::RecordInvalid => e
      @error_message = e.message
      false
    end

    private

    attr_reader :reservation_params, :guest_params

    def guest
      record = Guest.find_or_initialize_by(email: guest_params['email'])
      record.assign_attributes(guest_params)
      record.save if record.changed?
      record
    end
  end
end
