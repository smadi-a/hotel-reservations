# frozen_string_literal: true

class HashProperties
  def initialize(hash)
    @hash = hash
  end

  Properties = Struct.new(:schema_keys, :schema_md5_hash)

  def call
    Properties.new(schema_keys, schema_md5_hash)
  end

  private

  attr_reader :hash

  def schema_md5_hash
    Digest::MD5.hexdigest(schema_keys.join(','))
  end

  def schema_keys
    @payload_schema_keys ||= fetch_keys(hash)
  end

  def fetch_keys(sub_hash)
    sub_hash.each_with_object([]) do |(key, value), keys|
      if value.is_a?(Hash)
        keys.concat(fetch_keys(value).map { |inner_key| "#{key}##{inner_key}" })
      else
        keys << key
      end
      keys
    end
  end
end
