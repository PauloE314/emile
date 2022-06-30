require 'rails_helper'

RSpec.describe Recipe, type: :model do
  let(:creator) { User.create }
  let(:data) do
    params = attributes_for(:recipe)
    params[:creator] = creator
    params[:steps_attributes] = [attributes_for(:step)]
    params[:ingredients_attributes] = [attributes_for(:ingredient)]
    params
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

    it 'forces title format on category' do
      subject.category = 'brazilian'
      subject.save
      expect(subject.category).to eq('Brazilian') 
    end
  end

  describe '.filter_by_category' do
    before do
      described_class.create(data.merge({ category: 'Another' }))
      described_class.create(data.merge({ category: 'Category' }))
    end

    it 'returns only recipes categorized like the specified category' do
      other_recipes = described_class.where.not(category: 'Catego')
      expect(described_class.filter_by_category 'Category').to_not include(other_recipes)
    end 
  end

  describe '.filter_by_name' do
    before do
      described_class.create(data.merge({ name: 'Another' }))
      described_class.create(data.merge({ name: 'Name' }))
    end

    it 'returns only recipes named like the specified name' do
      other_recipes = described_class.where.not(name: 'Nam')
      expect(described_class.filter_by_name 'Name').to_not include(other_recipes)
    end
  end

  describe '.filter_by_creator' do
    before do
      described_class.create(data.merge({ creator: creator }))
      described_class.create(data.merge({ creator: create(:user) }))
    end

    it 'returns only recipes that have the specified name' do
      other_recipes = described_class.where.not(creator: creator)
      expect(described_class.filter_by_creator creator).to_not include(other_recipes)
    end 
  end
end
