# frozen_string_literal: true

class ApplicationController < ActionController::API
  private

  def authenticate
    Authentication.from_jwt(auth_header)
      .then { @current_user = _1[:user] }

  rescue ActiveRecord::RecordNotFound => e
    render json: { errors: e.message }, status: :unauthorized
  rescue JWT::DecodeError => e
    render json: { errors: e.message }, status: :unauthorized
  end

  def auth_header
    request.headers['Authorization']
  end
end
