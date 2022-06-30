require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  let(:recipe) { create(:recipe) }
  let(:data) { attributes_for(:ingredient).merge(recipe: recipe) }

  subject { Ingredient.new(data) }

  context 'when name is not present' do
    before { data[:name] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when amount is not present' do
    before { data[:amount] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when amount is not numeric' do
    before { data[:amount] = 'hello' }
    it { is_expected.to be_invalid }
  end

  context 'when amount is less than 0' do
    before { data[:amount] = -1 }
    it { is_expected.to be_invalid }
  end

  context 'when unit is not present' do
    before { data[:unit] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when unit is not in available units' do
    before { data[:unit] = 'another random unit' }
    it { is_expected.to be_invalid }
  end

  context 'when data is valid' do
    it { is_expected.to be_valid }
  end
end
