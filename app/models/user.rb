# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :favorites, dependent: :destroy, inverse_of: :user
  has_many :favorited_recipes, through: :favorites, source: :recipe
  has_many :recipes, foreign_key: :creator, dependent: :nullify

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :update, if: :password

  def favorited?(recipe)
    recipe.favorites.find { |favorite| favorite.user.id == id }.present?
  end
end
