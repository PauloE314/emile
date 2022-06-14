class Recipe::ShortSerializer < ActiveModel::Serializer
  attributes :id, :name, :category, :servings, :time, :created_at, :updated_at, :likes

  def likes
    object.favorites.count
  end
end
