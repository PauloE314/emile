# frozen_string_literal: true

class Step < ApplicationRecord
  belongs_to :recipe

  validates :description, presence: true
  validates :position, presence: true, numericality: { integer_only: true }
end
