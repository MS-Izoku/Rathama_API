class ApplicationController < ActionController::API
    before_action :authorize_api_key

# region: Constant Declarations
    API_KEY_HEADER = 'X-API-Key'
    AUTHORIZATION_KEY_HEADER = "Authorization"
# endregion


    def render_error(model_with_errors, message)
        { 
            error: { message: message },
            all_errors: model_with_errors.errors
        }
    end


    def authorize_api_key
        api_key = request.headers[API_KEY_HEADER]
        unless valid_api_key?(api_key)
          render json: { error: 'Unauthorized, API Key is invalid or missing' }, status: :unauthorized
        end
    end

    def authorize_jwt
        api_key = request.headers[API_KEY_HEADER]
        unless valid_api_key?(api_key)
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
    end


private

# authenticate a user using their headers and credentials
    def authenticate_user
        api_key = request.headers[AUTHORIZATION_KEY_HEADER]
        custom_header = request.headers[API_KEY_HEADER]
    
        # Add your authentication logic based on the presence of API key and custom header
        # For example, check the database for a user with the provided API key
    
        @current_user = User.find_by(api_key:)
    
        # Authentication successful
        if @current_user && custom_header_valid?(custom_header)
          @current_user
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
    end


    def valid_api_key?(api_key)
        # Implement your logic to validate the API key
        # This could involve checking against a database or some other mechanism
        # Return true if the key is valid, false otherwise
    end

# region JWT Validation

    def jwt_key
        Rails.application.credentials.jwt_key
    end


    def encode_jwt(payload)
        JWT.encode(payload, secret_key, 'HS256')
    end

    
    def decode_jwt
        JWT.decode(token, "anything", true, {algorithm: 'HS256'})[0]
    end

    
    # validate an existing JWT 
    def validate_jwt
    end

    # get the userId from the decoded JWT web token
    def user_id
        decoded_token.first["user_id"]
    end

    # get the current user by their Id
    def current_user
        user ||= User.find_by(id: user_id)
    end

    # is the current user valid (not null and found)
    def logged_in?
        !!current_user
    end

    def secret_key
        "__9@t4Am@_-_53@L0f7h3Anc13n7s__"
    end

# endregion

end
