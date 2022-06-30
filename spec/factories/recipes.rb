FactoryBot.define do
  factory :recipe do
    name { 'Fried eggs' }
    time { 3 }
    servings { 2 }
    category { 'simple' }
    image { nil }
    creator
    
    transient do
      full { false }
    end
    
    steps do
      full ? [association(:step)] : []
    end

    ingredients do
      full ? [association(:ingredient)] : []
    end
  end
end
