FactoryBot.define do
  factory :user, class: 'User' do
    email                  { 'testemail@gmail.com' }
    password               { 'password123' }
    password_confirmation  { 'password123' }

    trait :confirmed do
      confirmed_at   { Time.now - 2.days }
    end

  end
end
