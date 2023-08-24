# frozen_string_literal: true

module Reservations
  class Schema
    def initialize(schema_hash)
      @schema_hash = schema_hash
    end

    def parse_data(params)
      @params = params
      return unless schema_hash

      reservation_hash.merge(guest_params: guest_hash).tap do |hash|
        unless hash.dig(:guest_params, :phone_numbers).is_a?(Array)
          hash[:guest_params][:phone_numbers] = [hash.dig(:guest_params, :phone_numbers)]
        end
      end
    end

    private

    attr_reader :schema_hash, :params

    def reservation_hash
      %i[code start_date end_date adults children infants status host_currency payout_price security_price].each_with_object({}) do |attribute, hash|
        if schema_hash[attribute]
          dig_params = schema_hash[attribute].split('#')
          hash[attribute] = params.dig(*dig_params)
        end
        hash
      end
    end

    def guest_hash
      %i[email first_name last_name phone_numbers].each_with_object({}) do |attribute, hash|
        if schema_hash["guest_#{attribute}".to_sym]
          dig_params = schema_hash["guest_#{attribute}".to_sym].split('#')
          hash[attribute] = params.dig(*dig_params)
        end
        hash
      end
    end
  end
end
