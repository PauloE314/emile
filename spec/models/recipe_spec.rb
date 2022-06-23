require 'rails_helper'

RSpec.describe Recipe, type: :model do
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

  subject { Recipe.new(data) }

  context 'when creator is not present' do
    before { data[:creator] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when name is not present' do
    before { data[:name] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when time is not present' do
    before { data[:time] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when servings is not present' do
    before { data[:servings] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when category is not present' do
    before { data[:category] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when has invalid step' do
    before { data[:steps_attributes] = [{ description: nil, position: 1 }] }
    it { is_expected.to be_invalid }
  end

  context 'when there is same position steps' do
    before { data[:steps_attributes] << { description: "Another", position: 0 } }
    it { is_expected.to be_invalid }
  end


  context 'when has invalid ingredient' do
    before { data[:ingredients_attributes] = [{ name: nil, amount: 0, unit: 'kg' }] }
    it { is_expected.to be_invalid }
  end

  context 'when data is valid' do
    it { is_expected.to be_valid }
  end
end
