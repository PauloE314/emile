# frozen_string_literal: true

class Recipe < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :creator, class_name: 'User'
  has_many :steps, -> { order 'position ASC' }, dependent: :destroy, inverse_of: :recipe
  has_many :ingredients, dependent: :destroy, inverse_of: :recipe
  has_many :favorites, dependent: :destroy, inverse_of: :recipe

  accepts_nested_attributes_for :ingredients, :steps, allow_destroy: true

  has_one_attached :image

  validates :name, presence: true
  validates :category, presence: true
  validates :servings, presence: true
  validates :time, presence: true, numericality: { integer_only: true, greater_than: 0 }
  validate :ensure_unique_steps_positions
  validate :ensure_valid_image

  before_save { self.category = category.titleize }

  scope :filter_by_category, ->(category) { where_like category: category }
  scope :filter_by_name, ->(name) { where_like name: name }

  def ensure_unique_steps_positions
    errors.add 'steps', 'Repeated step positions are invalid' if steps.uniq(&:position).length != steps.length
  end

  def image_url
    url_for self.image if self.image.present?
  end

  def ensure_valid_image
    return unless image.attached?

    errors.add(:image, 'Invalid mime type') unless image.blob.image?
    errors.add(:image, 'Max size is 2MB') if image.blob.byte_size > 2.megabytes
  end
end
