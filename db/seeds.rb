# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# useful for development
include SecureRandom

# create admin user
admin = User.new
admin.email = "admin@yahoo.com"
admin.password = "admin1234"
admin.confirmed_at = Time.now
admin.save!

# prepare wedding
wedding = Weddings.new
wedding.groom = 'Jhon Doe'
wedding.bride = 'Melissa'
wedding.story = 'We love each other'
wedding.hashtag = '#TheWeddingOfJhonAndMelissa'
wedding.save!

# prepare venue_holy_matrimony - holy matrimony
venue_holy_matrimony = Venue.new
venue_holy_matrimony.name = 'Big Valley Grace Community Church'
venue_holy_matrimony.address = '4040 Tully Rd, Modesto, CA 95356'
venue_holy_matrimony.map_src = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3156.9546875295914!2d-121.0108296!3d37.69726319999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x809050e0c2a6b7b5%3A0x412c825ea2a51c7a!2sBig%20Valley%20Grace%20Community%20Church!5e0!3m2!1sid!2sid!4v1750389071904!5m2!1sid!2sid"
venue_holy_matrimony.start_time = Time.new(2027, 07, 07, 07, 0, 0, 0)
venue_holy_matrimony.end_time = Time.new(2027, 07, 07, 10, 0, 0, 0)
venue_holy_matrimony.max_attendees = 300
venue_holy_matrimony.venue_type = Venue::VENUE_TYPE_ENUM[:holy_matrimony]
venue_holy_matrimony.save!

# prepare venue_holy_matrimony - reception
venue_reception = Venue.new
venue_reception.name = 'Venice Boardwalk'
venue_reception.address = 'Beach pavillion in, Los Angeles, CA'
venue_reception.map_src = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d26467.899601269317!2d-118.49045881340265!3d33.98001122091108!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x80c2bbdcff2b25b3%3A0xedbe20babf53aa1b!2sVenice%20Boardwalk!5e0!3m2!1sid!2sid!4v1750389173788!5m2!1sid!2sid"
venue_reception.start_time = Time.new(2027, 07, 07, 19, 0, 0, 0)
venue_reception.end_time = Time.new(2027, 07, 07, 23, 0, 0, 0)
venue_reception.max_attendees = 500
venue_reception.venue_type = Venue::VENUE_TYPE_ENUM[:reception]
venue_reception.save!

# append holy matrimony + reception to wedding
holy_matrimony = WeddingVenue.new
holy_matrimony.wedding_id = wedding.id
holy_matrimony.venue_id = venue_holy_matrimony.id
holy_matrimony.save!

reception = WeddingVenue.new
reception.wedding_id = wedding.id
reception.venue_id = venue_reception.id
reception.save!

# prepare guest list
# guest 1
guest1 = Guest.new
guest1.name = "Milky"
guest1.gender = 0
guest1.contact = "411295213"
guest1.contact_source = 0
guest1.from_groom = true
guest1.save!

# guest 2
guest2 = Guest.new
guest2.name = "Cello"
guest2.gender = 1
guest2.contact = "cello.the.chihuahua"
guest2.contact_source = 1
guest2.from_groom = true
guest2.save!

# guest 3
guest3 = Guest.new
guest3.name = "Popeye"
guest3.gender = 1
guest3.contact = "41978261"
guest3.contact_source = 0
guest3.from_groom = false
guest3.save!

# guest 4
guest4 = Guest.new
guest4.name = "Donald"
guest4.gender = 1
guest4.contact = "donald.the.duck"
guest4.contact_source = 1
guest4.from_groom = false
guest4.save!

# prepare a holy matrimony and reception invitation for guest 1 and guest 2
invitation = Invitation.new
invitation.id = SecureRandom.uuid
invitation.participant = 2
invitation.wedding_id = wedding.id
invitation.attendance_type = Invitation::ATTENDANCE_TYPE_ENUM[:both]
invitation.attending = true
invitation.with_family = false
invitation.with_partner = false
invitation.sent = true
invitation.comments = "Congratulations!"
invitation.save!

# append guest1 and guest2 into our invitation
guestbook1 = InvitationGuest.new
guestbook1.invitation_id = invitation.id
guestbook1.guest_id = guest1.id
guestbook1.save!

guestbook2 = InvitationGuest.new
guestbook2.invitation_id = invitation.id
guestbook2.guest_id = guest2.id
guestbook2.save!

# prepare a holy matrimony only invitation for guest 3
invitation = Invitation.new
invitation.id = SecureRandom.uuid
invitation.participant = 4
invitation.wedding_id = wedding.id
invitation.attendance_type = Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony]
invitation.attending = true
invitation.with_family = true
invitation.with_partner = false
invitation.sent = true
invitation.comments = "Nice one brother!"
invitation.save!

# append guest3 into the invitation above
guestbook1 = InvitationGuest.new
guestbook1.invitation_id = invitation.id
guestbook1.guest_id = guest3.id
guestbook1.save!

# prepare a reception only invitation for guest 4
invitation = Invitation.new
invitation.id = SecureRandom.uuid
invitation.participant = 2
invitation.wedding_id = wedding.id
invitation.attendance_type = Invitation::ATTENDANCE_TYPE_ENUM[:reception]
invitation.attending = true
invitation.with_family = false
invitation.with_partner = true
invitation.sent = true
invitation.comments = "Happy wedding guys!!!"
invitation.save!

# append guest4 into the invitation above
guestbook1 = InvitationGuest.new
guestbook1.invitation_id = invitation.id
guestbook1.guest_id = guest4.id
guestbook1.save!
