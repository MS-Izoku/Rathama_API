class AuthenticationController < ApplicationController
    def login
        user = User.find_by(id: params[:id])
        if user && user.authenticate(params[:password])
            payload = {user_id: user.id}
            token = encode(payload)
            render json: { user , token }
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
        params.require(:user).permit(:id , :password)
    end
end