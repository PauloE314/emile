require 'rails_helper'

RSpec.describe Step, type: :model do
  let(:recipe) { Recipe.new }
  let(:data) do
    {
      description: 'Some ingredient',
      position: 1,
      recipe: recipe
    }
  end

  subject { Step.new(data) }

  context 'when description is not present' do
    before { data[:description] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when position is not present' do
    before { data[:position] = nil }
    it { is_expected.to be_invalid }
  end

  context 'when position is not numeric' do
    before { data[:position] = 'hello' }
    it { is_expected.to be_invalid }
  end
end
