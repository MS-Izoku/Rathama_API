class AuthenticationController < ApplicationController
    
    # user needs a profile serializer
    def login
        user = User.find_by(email: login_params[:email])
        if user && user.authenticate(login_params[:password])
            payload = { USER_ID => user.id, API_KEY_DIGEST => user.api_key_digest }
            token = encode_jwt(payload)
            render json: { user: user, token: token }
        end
    end

    def authenticate_token
        token = request.headers[AUTHORIZATION_KEY_HEADER]

        user = User.find_by(id: decode(token)[USER_ID])
        render json: user
    end

    def authenticate_api_key
        api_key = request.headers[API_KEY_HEADER]
        key_model = User.find_by(id: decode(token)[API_KEY_DIGEST])
        render json: key_model
    end

private 
    def login_params
        params.require(:user).permit(:email, :password)
    end
end