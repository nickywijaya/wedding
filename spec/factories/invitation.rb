# spec/factories/invitations.rb
FactoryBot.define do
  factory :invitation do
    association :wedding, factory: :wedding, strategy: :build

    id               { SecureRandom.uuid }
    participant      { 1 }
    attendance_type  { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

    trait :holy_matrimony do
      attendance_type  { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }
    end

    trait :reception do
      attendance_type  { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }
    end

    attending        { true }
    with_family      { true }
    sent             { false }
    comments         { 'test comment' }
  end
end
