# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe::FullSerializer do
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
      favorited: false,
      created_at: recipe.created_at,
      updated_at: recipe.updated_at,
      steps: [
        {
          id: recipe.steps.first.id,
          description: recipe.steps.first.description,
          position: recipe.steps.first.position,
        }
      ],
      ingredients: [
        {
          id: recipe.ingredients.first.id,
          amount: recipe.ingredients.first.amount,
          unit: recipe.ingredients.first.unit,
        }
      ],
      creator: {
        id: creator.id,
        name: creator.name,
        email: creator.email
      }
    )
  end

  context 'when user has liked the recipe' do
    let(:scope) { double(favorited?: true) }
    subject { described_class.new(recipe, scope: scope).as_json }

    it { is_expected.to include(favorited: true) }
  end
end