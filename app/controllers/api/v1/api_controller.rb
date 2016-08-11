module Api::V1
  class ApiController < ApplicationController
    include ActionController::HttpAuthentication::Token::ControllerMethods

    #before_action :authenticate, except: [:login_with_fb]
    before_action :set_headers

    def set_headers
      headers['Access-Control-Allow-Origin'] = "*"
    end

    @current_user = nil

    protected
    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        @current_user = User.get_user_from_token token
        return true if @current_user.present?
      end
    end

    def render_unauthorized
      render json: {message: 'Please Login To Continue'}, status: 401
    end
  end
end