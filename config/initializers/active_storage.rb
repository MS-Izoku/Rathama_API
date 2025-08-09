# config/initializers/active_storage.rb
Rails.application.config.after_initialize do
  class ProductionUnsetException < StandardError
  end

  ENV_CONFIG = {
    production: { host: ENV.fetch('HOST', 'rathama-api.onrender.com'), protocol: 'https' },
    development: { host: ENV.fetch('HOST', 'rathama-api.onrender.com'), protocol: 'https' },
    local: { host: 'localhost', port: 3000, protocol: 'http' }
  }.freeze

  determine_env = lambda do
    if Rails.env.production?
      # Prevent accidental production use
      # raise ProductionUnsetException, 'Production environment not configured yet'
      ENV_CONFIG[:production] # this will be changed once an actual production server is made
    elsif Rails.env.development? && ENV['RENDER']
      ENV_CONFIG[:development]
    else
      ENV_CONFIG[:local]
    end
  end

  ActiveStorage::Current.url_options = determine_env.call
end
