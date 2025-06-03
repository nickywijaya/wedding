FactoryBot.define do
  factory :user, class: 'User' do
    email                  { 'test-email' }
    encrypted_password     { 'test-password' }
    reset_password_token   { 'test-reset-password-token' }
    reset_password_sent_at { nil }
    remember_created_at    { nil }

    trait :confirmed do
      confirmed_at   { Time.now - 2.days }
    end

  end
end
