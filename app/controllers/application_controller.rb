class ApplicationController < ActionController::API
	include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate
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
      @current_user = User.find_by(access_token: token)
      return true if @current_user.present?
    end
  end

  def render_unauthorized
    render json: {status: false, message: 'Invalid Authentication'}, status: 401
  end
end
