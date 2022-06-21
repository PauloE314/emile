# frozen_string_literal: true

class ApplicationController < ActionController::API
  serialization_scope :current_user

  rescue_from ActiveRecord::RecordNotFound do
    render status: :not_found
  end

  rescue_from ActionController::ParameterMissing do render status: :bad_request end

  attr :current_user

  private

  def authenticate!
    @current_user = Authentication.from_jwt(auth_header)[:user]
  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :unauthorized
  rescue JWT::DecodeError => e
    render json: { errors: e.message }, status: :unauthorized
  end

  def extract_credentials
    @current_user = Authentication.from_jwt(auth_header)[:user]
  rescue StandardError
  end

  def auth_header
    request.headers['Authorization']
  end
end
