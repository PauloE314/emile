# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :favorites, dependent: :destroy, inverse_of: :user
  has_many :recipes, through: :favorites

  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :update, if: :password

  def as_json(options)
    super({ except: :password_digest }.merge(options))
  end

  def favorited?(recipe)
    recipe.favorite.find { |favorite| favorite.user.id == id }.present?
  end
end
