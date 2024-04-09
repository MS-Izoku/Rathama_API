class AuthenticationController < ApplicationController
    
    # user needs a profile serializer
    def login
        user = User.find_by(email: login_params[:email])
        if user && user.authenticate(login_params[:password])
            payload = { user_id: user.id }
            token = encode_jwt(payload)
            render json: { user: user, token: token }
        end
    end

    def authenticate_token
        token = request.headers["Authorization"]
        apiKey = request.headers["X-API-Key"]

        user = User.find_by(id: decode(token)["user_id"])
        render json: user
    end

private 
    def login_params
        params.require(:user).permit(:email, :password)
    end
end