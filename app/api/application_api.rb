# frozen_string_literal: true

require 'grape'

class ApplicationAPI < Grape::API
  use ::APIAuthMiddleware

  content_type :json, 'application/json; charset=utf-8'
  format :json

  helpers ApplicationAPIHelpers

  mount ReservationsAPI
end
