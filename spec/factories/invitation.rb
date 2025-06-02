# spec/factories/invitations.rb
FactoryBot.define do
  factory :invitation do
    association :wedding, factory: :wedding, strategy: :build

    id               { SecureRandom.uuid }
    participant      { 1 }
    attendance_type  { Invitation::ATTENDANCE_TYPE_ENUM[:both] }
    attending        { true }
    with_family      { true }
    sent             { false }
    comments         { 'test comment' }
  end
end
