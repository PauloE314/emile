class Recipe::ShortSerializer < ApplicationSerializer
  attributes :id, :name, :category, :servings, :time, :created_at, :likes

  belongs_to :creator

  def time
    t('duration', count: object.time)
  end

  def servings
    t('servings', count: object.servings)
  end

  def likes
    object.favorites.count
  end

  class UserSerializer < ApplicationSerializer
    attributes :id, :name
  end
end
