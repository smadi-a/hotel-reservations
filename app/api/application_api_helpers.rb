# frozen_string_literal: true

module ApplicationAPIHelpers
  def send_success_message(message = nil)
    hash = { status: 'success' }
    hash[:message] = message if message
    hash
  end
end
