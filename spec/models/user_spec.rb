require 'rails_helper'

RSpec.describe User, type: :model do
  let(:data) do
    {
      name: 'name',
      password: 'password',
      password_confirmation: 'password',
      email: 'email@email.com'
    }
  end

  subject { User.new(data) }

  context 'when name is not present' do
    before { data[:name] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when email is not present' do
    before { data[:email] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when email does not fit email format' do
    before { data[:email] = 'another format' }
    it { is_expected.to be_invalid }
  end

  context 'when password is not present' do
    before { data[:password] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when password_confirmation is not present' do
    before { data[:password_confirmation] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when password differs from password_confirmation ' do
    before { data[:password_confirmation] = 'different password' }
    it { is_expected.to be_invalid }
  end

  context 'when data is correct' do
    it { is_expected.to be_valid }
  end

  describe '#favorited?' do
    let(:recipe_data) do
      {
        name: 'Recipe',
        creator: subject,
        time: 10,
        servings: 5,
        category: 'brazilian',
        image: nil,
        steps_attributes: [],
        ingredients_attributes: [],
      }
    end
    let(:favorited_recipe) { Recipe.create(recipe_data) }
    let(:not_favorited_recipe) { Recipe.create(recipe_data) }

    before { Favorite.new(user: subject, recipe: favorited_recipe).save }
    
    context 'when user has favorited the recipe' do
      it 'returns true' do
        expect(subject.favorited? favorited_recipe).to be_truthy
      end      
    end

    context 'when user has not favorited the recipe' do
      it 'returns true' do
        expect(subject.favorited? not_favorited_recipe).to be_falsy
      end      
    end
  end
end
