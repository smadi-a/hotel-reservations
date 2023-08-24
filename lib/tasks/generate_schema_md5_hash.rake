# frozen_string_literal: true

require_relative '../../app/services/hash_properties'

namespace :json do
  desc 'Generate MD5 hash for JSON object schema'
  task :generate_hash do
    print 'paste single-line JSON object here: '
    user_input = $stdin.gets.chomp

    begin
      hash = JSON.parse(user_input)
      md5_hash = HashProperties.new(hash).call.schema_md5_hash
      puts md5_hash
    rescue JSON::ParserError => e
      puts "Error parsing JSON: #{e.message}"
    end
  end
end
