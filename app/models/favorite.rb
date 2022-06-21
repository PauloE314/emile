# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe, counter_cache: true

  validate :prevent_duplicate

  def prevent_duplicate
    repeated = self.class.find_by(user_id: user.id, recipe_id: recipe.id).present?
    errors.add 'user', 'User already favorited this recipe' if repeated
  end
end
