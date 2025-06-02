FactoryBot.define do
  factory :wedding_venue do
    association :wedding, factory: :wedding, class_name: 'Weddings'
    association :venue
  end
end