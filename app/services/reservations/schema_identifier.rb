# frozen_string_literal: true

module Reservations
  class SchemaIdentifier
    def initialize(payload)
      @payload = payload
    end

    def call
      schema_hash = schemas.detect { |schema| schema['identifier'] == payload_schema_identifier }
      return schema_hash unless schema_hash.nil?

      schemas.detect { |schema| (schema.values & payload_schema_keys).size == payload_schema_keys.size }
    end

    private

    attr_reader :payload

    def payload_schema_identifier
      Digest::MD5.hexdigest(payload_schema_keys.join(','))
    end

    def payload_schema_keys
      @payload_schema_keys ||= fetch_keys(payload)
    end

    def fetch_keys(hash)
      hash.each_with_object([]) do |(key, value), keys|
        if value.is_a?(Hash)
          keys.concat(fetch_keys(value).map { |inner_key| "#{key}##{inner_key}" })
        else
          keys << key
        end
        keys
      end
    end

    def schemas
      DEFINED_SCHEMAS
    end
  end
end
