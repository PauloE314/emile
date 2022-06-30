FactoryBot.define do
  factory :ingredient do
    name { 'egg' }
    amount { 2 }
    unit { 'unidade' }
    recipe
  end
end
