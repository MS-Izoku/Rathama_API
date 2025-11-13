# config/initializers/active_storage.rb
ENV_CONFIG = {
  production: { host: ENV.fetch('HOST', 'rathama-api.onrender.com'), protocol: 'https' },
  staging: { host: ENV.fetch('HOST', 'rathama-api.onrender.com'), protocol: 'https' },
  development: { host: 'localhost', port: 3000, protocol: 'http' }
}.freeze

BLOCKOUT = '[=======================================================]'.freeze

# config/initializers/active_storage.rb
class ActiveStorageConfiguration
  def self.env_config
    if Rails.env.production?
      ENV_CONFIG[:production]
    elsif Rails.env.development? && ENV['RENDER']
      ENV_CONFIG[:staging]
    else
      ENV_CONFIG[:development]
    end
  end

  def self.configure!
    config = env_config
    Rails.application.routes.default_url_options = config
    ActiveStorage::Current.url_options = config
  end
end

Rails.application.config.after_initialize do
  ActiveStorageConfiguration.configure!
end
