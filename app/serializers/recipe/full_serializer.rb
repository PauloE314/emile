class Recipe::FullSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :servings, :time, :created_at, :updated_at, :likes, :favorited

  has_many :steps
  has_many :ingredients

  def likes
    object.favorites.count
  end

  def favorited
    scope&.favorited?(object) || false
  end

  class StepSerializer < ActiveModel::Serializer
    attributes :id, :description, :position
  end

  class IngredientSerializer < ActiveModel::Serializer
    attributes :id, :amount, :unit
  end
end
