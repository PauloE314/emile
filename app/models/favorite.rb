# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe, counter_cache: true

  validate :prevent_duplicate

  def prevent_duplicate
    users_ids = recipe.favorites.includes(:user).map { |favorite| favorite.user.id }
    errors.add 'user', 'User already favorited this recipe' if users_ids.include? user.id
  end
end
