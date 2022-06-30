require 'rails_helper'

RSpec.describe Step, type: :model do
  let(:recipe) { create(:recipe) }
  let(:data) { { recipe: recipe, description: 'Some step', position: 1 } }

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
