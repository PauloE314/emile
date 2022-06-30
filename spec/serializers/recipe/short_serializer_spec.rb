# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe::ShortSerializer do
  let(:creator) { User.create }
  let(:data) do
    {
      name: 'Recipe',
      creator: creator,
      time: 10,
      servings: 5,
      category: 'brazilian',
      image: nil,
      steps_attributes: [
        {
          position: 0,
          description: 'step one'
        }
      ],
      ingredients_attributes: [
        {
          name: 'first ingredient',
          amount: 1,
          unit: 'kg'  
        }
      ],
    }
  end

  let(:recipe) { Recipe.create(data) }
  subject { described_class.new(recipe).as_json }

  it do
    is_expected.to eq(
      id: recipe.id,
      name: 'Recipe',
      category: 'Brazilian',
      servings: '5 porções',
      time: '10 minutos',
      likes: 0,
      image: nil,
      created_at: recipe.created_at,
      creator: {
        id: creator.id,
        name: creator.name
      }
    )
  end
end