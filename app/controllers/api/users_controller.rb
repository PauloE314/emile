module Api
  class UsersController < ApplicationController
    before_action :authenticate, only: %i[ me ]
    before_action :set_user, only: %i[ show update destroy ]
  
    def index
      render json: User.all
    end
  
    def show
      render json: @user
    end

    def me
      render json: @current_user
    end
  
    def create
      @user = User.new user_params
  
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :bad_request
      end
    end
  
    def update
      if @user.update user_params
        render json: @user
      else
        render json: @user.errors, status: :bad_request
      end
    end
  
    def destroy
      @user.destroy
    end
  
    private
  
    def set_user
      @user = User.find params[:id]
    end
  
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation, :email)
    end
  end
end