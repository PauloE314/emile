# frozen_string_literal: true

class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.references :creator, null: false, foreign_key: { to_table: 'users' }
      t.string :name, null: false
      t.string :image_url
      t.string :category
      t.integer :servings
      t.integer :time

      t.timestamps
    end

    create_table :ingredients do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :amount, null: false
      t.string :unit, null: false
    end

    create_table :steps do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :description, null: false
      t.integer :position, null: false
    end
  end
end
