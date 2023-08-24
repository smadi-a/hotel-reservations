# frozen_string_literal: true

module Reservations
  class Schema
    def initialize(schema_hash)
      @schema_hash = schema_hash
    end

    def parse_data(params)
      @params = params
      return unless schema_hash

      reservation_hash.merge('guest_params' => guest_hash).tap do |hash|
        unless hash.dig('guest_params', 'phone_numbers').is_a?(Array)
          hash['guest_params']['phone_numbers'] = [hash.dig('guest_params', 'phone_numbers')]
        end
      end
    end

    private

    attr_reader :schema_hash, :params

    def reservation_hash
      attributes = %w[code start_date end_date adults children infants status host_currency payout_price security_price]
      build_hash(attributes)
    end

    def guest_hash
      attributes = %w[email first_name last_name phone_numbers]
      build_hash(attributes, 'guest')
    end

    def build_hash(attributes, key_prefix = nil)
      attributes.each_with_object({}) do |attribute, hash|
        key = key_prefix ? "#{key_prefix}_#{attribute}" : attribute

        if schema_hash[key]
          dig_params = schema_hash[key].split('#') # where "#" is used in the schema to denote nesting
          hash[attribute] = params.dig(*dig_params)
        end
        hash
      end
    end
  end
end
