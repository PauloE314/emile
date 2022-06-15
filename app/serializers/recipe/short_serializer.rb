# frozen_string_literal: true

class Recipe
  class ShortSerializer < ApplicationSerializer
    attributes :id, :name, :category, :servings, :time, :created_at, :likes, :image

    belongs_to :creator

    def time
      t('duration', count: object.time)
    end

    def servings
      t('servings', count: object.servings)
    end

    def likes
      object.favorites.size
    end

    def image
      object.image_url
    end

    class UserSerializer < ApplicationSerializer
      attributes :id, :name
    end
  end
end
