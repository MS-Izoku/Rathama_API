class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def authorize_api_key(api_key)

    unless valid_api_key?(api_key)
      render json: { error: 'Unauthorized, API Key is invalid or missing' }, status: :unauthorized
    end
  end

  private
  # search for an API Key via it's normal nam
  def has_permission?(key, permission)
    # key.permissions.include?(permission.to_s) # implement when Postgres has been implemented
    true
  end

end
