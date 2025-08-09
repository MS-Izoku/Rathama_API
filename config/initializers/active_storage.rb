# config/initializers/active_storage.rb
Rails.application.config.after_initialize do
  class ProductionUnsetException < StandardError;
  # Missing 'end' here for the class definition

  ENV_CONFIG = {
    production: { host: ENV.fetch('HOST', 'rathama-api.onrender.com'), protocol: 'https' },
    development: { host: ENV.fetch('HOST', 'rathama-api.onrender.com'), protocol: 'https' },
    local: { host: 'localhost', port: 3000, protocol: 'http' }
  }.freeze

  def determine_env
    if Rails.env.production?
      # ENV_CONFIG[:production]
      raise ProductionUnsetException.new("Production environment not configured yet") # Prevent accidental production use
    elsif Rails.env.development? && ENV['RENDER']
      ENV_CONFIG[:development]
    else
      ENV_CONFIG[:local]
    end
  end

  ActiveStorage::Current.url_options = determine_env
end