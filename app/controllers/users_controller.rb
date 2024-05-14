class UsersController < ApplicationController
  before_action :authenticate_user
  skip_before_action :authenticate_user, only: [:create]

  #skip_before_action :authorize_api_key, only: [:create]

  def profile; end

  # Create and Validate a New User
  def create
    found_user = User.where(email: user_creation_params[:email]).or(User.where(username: user_creation_params[:username])).first

    # basic validation messaging
    if found_user # if the user is found, tell the user which field matches
      if found_user.email == user_creation_params[:email] && found_user.username == user_creation_params[:username]
        return render json: { errors: ['Username and Email already in use'] }, status: :bad_request
      elsif found_user.email == user_creation_params[:email]
        return render json: { errors: ['Email already in use'] }, status: :bad_request
      else
        return render json: { errors: ['Username already in use'] }, status: :bad_request
      end
    end
    
    if user_creation_params[:password] != user_creation_params[:password_confirmation]
      return render json: { errors: ['Passwords must match'] }, status: :bad_requestpcreate
    end

    # password validation returns either an array of errors or the raw password
    password_validation = User.validate_password_format(user_creation_params[:password])
    if password_validation != user_creation_params[:password]
      return render json: { errors: password_validation }, status: :bad_request
    end

    # create the user and check for errors
    user = User.create!(user_creation_params)

    payload = { USER_ID => user.id, API_KEY_DIGEST => user.api_key_digest }
    token = encode_jwt(payload)
    render json: { user: user, token: token }, status: :created
  end

  def update_username
  end

  # sends an email to a users email address to confirm the change
  def change_email
  end

  # reached via link to confirm that a users email is correct and belongs to them
  def confirm_change_email
  end

  def change_password
  end

  def show
    render json: @current_user
  end


  def destroy
    @current_user.destroy
    render json: { user_data: @current_user, message: "User has been deleted" }, status: :ok
  end

# region: API Keys
  def grant_api_key; end

  def rotate_api_key; end
# endregion

  private

  def user_creation_params
    params.permit(:username, :password, :password_confirmation, :email)
  end

  def change_password_params
    params.require(:user).permit(:password, password_confirmation)
  end

  def change_email_params
    params.require(:user).permit(:email)
  end

  def confirm_change_email_params
    params.permit(:email, :confirmation_id)
  end
end
