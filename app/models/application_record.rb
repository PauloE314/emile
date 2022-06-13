# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.where_like(**fields)
    field, value = fields.to_a.first
    where "#{field} like ?", "%#{value}%"
  end
end
