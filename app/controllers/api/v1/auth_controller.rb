class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:login]

  def login
    @user = User.find_by(username: auth_params['username'])
    if @user && @user.authenticate(auth_params['password'])
      token = encode_token({user_id: @user.id})
      render json: {user: @user.format, jwt: token}, status: :accepted
    else
      render json: {message: 'Invalid Username or Password'}, status: :unauthorized
    end
  end

  def reauth
    render json: { user: @user.format }, status: :accepted
  end

  private

  def auth_params
    params.require(:user).permit(:username, :password)
  end

end
