class UsersController < ApplicationController
  def login
    email = params[:email]
    password = params[:password]
    user = MyApi::User.where(email: email, password: password).all.first
    if user.present?
      session[:api_key] = user['api-key']
      render json: { error: false, api_key: user['api-key'] }
    else
      session[:api_key] = nil
      render json: { error: true, message: 'Incorrect email or password' }
    end
  end
end
