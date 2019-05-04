module Api
  class BaseController < ApplicationController
    before_action :authorize_user

    def authorize_user
      user = MyApi::User.where(api_key: session[:api_key]).all
      render json: { error: 'Access Denied' } if user.empty?
    end
  end
end
