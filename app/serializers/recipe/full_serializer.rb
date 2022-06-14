# frozen_string_literal: true

module Recipe
  class FullSerializer < Recipe::ShortSerializer
    attributes :favorited, :updated_at

    has_many :steps
    has_many :ingredients

    def favorited
      scope&.favorited?(object) || false
    end

    class UserSerializer < ApplicationSerializer
      attributes :id, :name, :email
    end

    class StepSerializer < ApplicationSerializer
      attributes :id, :description, :position
    end

    class IngredientSerializer < ApplicationSerializer
      attributes :id, :amount, :unit
    end
  end
end
