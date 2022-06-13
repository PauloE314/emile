# frozen_string_literal: true

class Ingredient < ApplicationRecord
  UNITS = ['unidade', 'kg', 'colheres de sopa'].freeze

  belongs_to :recipe

  validates :name, presence: true
  validates :amount, presence: true, numericality: { integer_only: true, greater_than: 0 }
  validates :unit, presence: true, inclusion: { in: UNITS }
end
