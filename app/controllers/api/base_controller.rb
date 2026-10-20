module Api
  class BaseController < ActionController::API
    include ActionController::HttpAuthentication::Token::ControllerMethods

    class BadRequest < StandardError; end

    before_action :force_json

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActionController::ParameterMissing, with: :missing_parameter
    rescue_from ActionDispatch::Http::Parameters::ParseError, with: :unreadable_body
    rescue_from BadRequest, with: :bad_request

    def route_not_found
      render_errors("No such route", :not_found)
    end

    private

    def force_json
      request.format = :json
    end

    # Los controladores que necesitan token lo piden con: before_action :authenticate!
    def authenticate!
      authenticated = authenticate_with_http_token do |token, _options|
        expected = Rails.application.credentials.api_token.to_s
        expected.present? && ActiveSupport::SecurityUtils.secure_compare(token, expected)
      end
      return if authenticated

      response.set_header("WWW-Authenticate", 'Bearer realm="Wheelhouse API"')
      render_errors("Missing or invalid token", :unauthorized)
    end

    def render_errors(messages, status)
      render json: { errors: Array(messages) }, status: status
    end

    def money(amount)
      format("%.2f", amount)
    end

    def record_not_found(error)
      message = error.model ? "#{error.model} with id #{error.id} was not found" : "Record not found"
      render_errors(message, :not_found)
    end

    def missing_parameter(error)
      render_errors("The request body must include #{error.param}", :bad_request)
    end

    def unreadable_body(_error)
      render_errors("The request body is not valid JSON", :bad_request)
    end

    def bad_request(error)
      render_errors(error.message, :bad_request)
    end
  end
end