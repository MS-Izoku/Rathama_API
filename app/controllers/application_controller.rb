class ApplicationController < ActionController::API
    #before_action :authorize_api_key

# region: Constant Declarations
    API_KEY_HEADER = 'X-API-Key'
    AUTHORIZATION_KEY_HEADER = "Authorization"
# endregion

    def self.api_key_header
        API_KEY_HEADER
    end

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


    # authenticate a user using their headers and credentials
    def authenticate_user
        api_key = request.headers[AUTHORIZATION_KEY_HEADER]
        bearer = get_bearer
    
        # Add your authentication logic based on the presence of API key and custom header
        # For example, check the database for a user with the provided API key
    
        @current_user = User.find_by(id: decode_jwt(bearer)[USER_ID])
    
        # Authentication successful
        if @current_user
          @current_user
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
    end


    # when used, returns the user_id (and eventually, API Key data)
    def decode_jwt(token)
        token = JWT.decode(token, secret_key, true, {algorithm: 'HS256'})[0]
    end

    private
    # returns true if the API key belongs to the user and is currently active
    def valid_api_key?(api_key, user_id)
        api_key_string = request.headers[API_KEY_HEADER]

        # find the API Key in the databse
        # return true of false based on whether the api_key's is_active field is true/false and belongs to the user
    end

    # check if the API Key has the required permissions to perform an action
    def validate_api_key_permissions(required_permissions)
        api_key_string = request.headers[API_KEY_HEADER]
        true
    end

# region JWT Validation for AUTH

    def jwt_key
        Rails.application.credentials.jwt_key
    end


    def encode_jwt(payload)
        JWT.encode(payload, secret_key, 'HS256')
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
        return @current_user if defined?(@current_user)
    
        token = request.headers[AUTHORIZATION_KEY_HEADER]&.split&.last
        return unless token
    
        decoded_token = decode_jwt(token)
        @current_user ||= User.find_by(id: decoded_token["user_id"])
    end

    def get_bearer
        bearer = request.headers[AUTHORIZATION_KEY_HEADER]
        bearer = bearer.sub "Bearer " , ""

        p "======================================="
        p bearer

        bearer
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
