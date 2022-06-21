# frozen_string_literal: true

class AddFavoritesCountToRecipes < ActiveRecord::Migration[7.0]
  def change
    add_column :recipes, :favorites_count, :integer
  end
end
