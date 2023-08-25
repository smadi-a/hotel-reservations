# frozen_string_literal: true

module Reservations
  class SchemaIdentifier
    def initialize(payload)
      @payload = payload
    end

    def call
      return nil if payload.blank?

      payload_props = HashProperties.new(payload).call
      schema_hash = schemas.detect { |schema| schema['identifier'] == payload_props.schema_md5_hash }
      return schema_hash unless schema_hash.nil?

      schemas.detect { |schema| (schema.values & payload_props.schema_keys).size == payload_props.schema_keys.size }
    end

    private

    attr_reader :payload

    def schemas
      DEFINED_SCHEMAS
    end
  end
end
