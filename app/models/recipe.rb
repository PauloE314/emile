# frozen_string_literal: true

class Recipe < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :steps, -> { order 'position ASC' }, dependent: :destroy
  has_many :ingredients, dependent: :destroy

  accepts_nested_attributes_for :ingredients, :steps, allow_destroy: true

  validates :name, presence: true
  validates :category, presence: true
  validates :servings, presence: true
  validates :time, presence: true, numericality: { integer_only: true, greater_than: 0 }
  validate :ensure_unique_steps_positions

  before_save { self.category = category.titleize }

  scope :filter_by_category, ->(category) { where_like category: category }
  scope :filter_by_name, ->(name) { where_like name: name }

  def ensure_unique_steps_positions
    errors.add 'steps', 'Repeated step positions are invalid' if steps.uniq(&:position).length != steps.length
  end
end
