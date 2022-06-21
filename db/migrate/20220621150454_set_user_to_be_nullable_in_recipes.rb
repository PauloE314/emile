# frozen_string_literal: true

class SetUserToBeNullableInRecipes < ActiveRecord::Migration[7.0]
  def change
    change_column_null :recipes, :creator_id, true
  end
end
