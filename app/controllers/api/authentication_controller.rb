# frozen_string_literal: true

module Api
  class AuthenticationController < ApplicationController
    def login
      @user = User.find_by(email: login_params[:email])

      if @user&.authenticate(login_params[:password])
        render json: credentials
      else
        render status: :unauthorized
      end
    end

    private

    def login_params
      @login_params ||= params.require(:login).permit(:email, :password)
    end

    def credentials
      @credentials ||= Authentication.create_credentials(@user)
    end
  end
end
