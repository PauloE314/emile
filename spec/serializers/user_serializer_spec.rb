# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserSerializer do
  let(:data) do
    {
      name: 'name',
      password: 'password',
      password_confirmation: 'password',
      email: 'email@email.com'
    }
  end

  let(:user) { User.create(data) }
  subject { described_class.new(user).as_json }

  it do
    is_expected.to match({
      id: a_kind_of(Integer),
      name: data[:name],
      email: data[:email],
      updated_at: a_kind_of(ActiveSupport::TimeWithZone),
      created_at: a_kind_of(ActiveSupport::TimeWithZone),
    })
  end
end