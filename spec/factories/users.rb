FactoryBot.define do
  factory :user, aliases: [:creator] do
    name { 'Robert' }
    email { 'robert@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
