# spec/factories/venue.rb
FactoryBot.define do
  factory :venue do

    name          { 'test-venue' }
    address       { 'test-address' }
    map_src       { 'test-map-src' }
    start_time    { Time.new(2025, 06, 07, 11, 0, 0, 0) }
    end_time      { Time.new(2025, 06, 07, 13, 0, 0, 0) }
    max_attendees { 50 }
    venue_type    { Venue::VENUE_TYPE_ENUM[:holy_matrimony] }

    transient do
      invitation_count { 2 } # default
      invitation_participant { 2 } # default
      attendance_type { Invitation::ATTENDANCE_TYPE_ENUM[:both] } # default
    end

    trait :with_guests do
      after(:create) do |venue, evaluator|
        wedding = create(:wedding)
        create(:wedding_venue, venue: venue, wedding: wedding)
        create_list(:invitation, evaluator.invitation_count, wedding: wedding, participant: evaluator.invitation_participant, attendance_type: evaluator.attendance_type)
      end
    end

    trait :with_guests_half_attending do
      after(:create) do |venue, evaluator|
        wedding = create(:wedding)
        create(:wedding_venue, venue: venue, wedding: wedding)

        half_count = evaluator.invitation_count / 2
        attending_count = half_count.odd? ? half_count + 1 : half_count

        # attending invitation
        create_list(:invitation, half_count, wedding: wedding, participant: evaluator.invitation_participant, attendance_type: evaluator.attendance_type)

        # not attending invitation
        create_list(:invitation, half_count, wedding: wedding, participant: evaluator.invitation_participant, attendance_type: evaluator.attendance_type, attending: false)
      end
    end

    trait :with_guests_half_confirmed do
      after(:create) do |venue, evaluator|
        wedding = create(:wedding)
        create(:wedding_venue, venue: venue, wedding: wedding)

        half_count = evaluator.invitation_count / 2
        attending_count = half_count.odd? ? half_count + 1 : half_count

        # attending invitation
        create_list(:invitation, half_count, wedding: wedding, participant: evaluator.invitation_participant, attendance_type: evaluator.attendance_type)

        # not attending invitation
        create_list(:invitation, half_count, wedding: wedding, participant: evaluator.invitation_participant, attendance_type: evaluator.attendance_type, attending: nil)
      end
    end

    trait :with_all_guests_attending do
      after(:create) do |venue, evaluator|
        wedding = create(:wedding)
        create(:wedding_venue, venue: venue, wedding: wedding)
        create_list(:invitation, evaluator.invitation_count, wedding: wedding, participant: evaluator.invitation_participant, attendance_type: evaluator.attendance_type, attending: true)
      end
    end

    trait :with_invitation_half_sent do
      after(:create) do |venue, evaluator|
        wedding = create(:wedding)
        create(:wedding_venue, venue: venue, wedding: wedding)

        half_count = evaluator.invitation_count / 2
        attending_count = half_count.odd? ? half_count + 1 : half_count

        # invitation not sent
        create_list(:invitation, half_count, wedding: wedding, attendance_type: evaluator.attendance_type, sent: false)

        # invitation sent
        create_list(:invitation, half_count, wedding: wedding, attendance_type: evaluator.attendance_type, sent: true)
      end
    end

    trait :with_invitation_all_sent do
      after(:create) do |venue, evaluator|
        wedding = create(:wedding)
        create(:wedding_venue, venue: venue, wedding: wedding)
        create_list(:invitation, evaluator.invitation_count, wedding: wedding, attendance_type: evaluator.attendance_type, sent: true)
      end
    end

    trait :reception do
      venue_type  { Venue::VENUE_TYPE_ENUM[:reception] }
    end
  end
end
