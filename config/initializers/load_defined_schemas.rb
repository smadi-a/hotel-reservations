# frozen_string_literal: true

DEFINED_SCHEMAS = YAML.load_file(Rails.root.join('config', 'defined_schemas.yml'))&.map(&:last)&.flatten&.compact || []
