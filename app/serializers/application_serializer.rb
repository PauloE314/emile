class ApplicationSerializer < ActiveModel::Serializer
  delegate :t, to: I18n
  delegate :l, to: I18n
end