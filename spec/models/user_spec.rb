require 'rails_helper'

RSpec.describe User, type: :model do
  let(:data) { attributes_for(:user) }

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
    let(:favorited_recipe) { create(:recipe) }
    let(:not_favorited_recipe) { create(:recipe) }

    before { create(:favorite, user: subject, recipe: favorited_recipe) }
    
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
