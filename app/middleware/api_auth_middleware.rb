class APIAuthMiddleware < Grape::Middleware::Base
  def before
    api_key = env['HTTP_X_API_KEY']
    unauthorized! unless valid_api_key?(api_key)
  end

  private

  def valid_api_key?(api_key)
    return false unless api_key

    APIKey.exists?(key: api_key, disabled: false)
  end

  def unauthorized!
    throw :error, message: 'Unauthorized', status: 401
  end
end
