# frozen_string_literal: true

class APIKey < ApplicationRecord
  validates :key, presence: true
  validates :disabled, inclusion: { in: [true, false] }
end
