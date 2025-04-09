# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# useful for development
include SecureRandom

# prepare wedding
wedding = Weddings.new
wedding.groom = 'Nicky'
wedding.bride = 'Nova'
wedding.story = 'Our love began in 2019 and still feels new all the time.'
wedding.hashtag = '#NickyAndNovaWedding'
wedding.save!

# prepare venue_holy_matrimony - holy matrimony
venue_holy_matrimony = Venue.new
venue_holy_matrimony.name = 'GBI Basilea Christ Cathedral'
venue_holy_matrimony.address = 'Jl. Gading Golf Boulevard No.888, Gading, Kec. Serpong, Kabupaten Tangerang, Banten 15332'
venue_holy_matrimony.map_src = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3966.0371310413143!2d106.64307439999999!3d-6.258839399999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69fb9b62d7f855%3A0x76001147a9a1e55d!2sGBI%20Basilea%20Christ%20Cathedral!5e0!3m2!1sen!2sid!4v1738648825850!5m2!1sen!2sid"
venue_holy_matrimony.start_time = Time.new(2025, 06, 07, 11, 0, 0, 0)
venue_holy_matrimony.end_time = Time.new(2025, 06, 07, 13, 0, 0, 0)
venue_holy_matrimony.max_attendees = 70
venue_holy_matrimony.venue_type = Venue::VENUE_TYPE_ENUM[:holy_matrimony]
venue_holy_matrimony.save!

# prepare venue_holy_matrimony - reception
venue_reception = Venue.new
venue_reception.name = 'Umatis Resto & Venue'
venue_reception.address = 'BSD City, Kavling Taman Kota Barat Lot No.II.6, Sampora, Kec. Cisauk, Kabupaten Tangerang, Banten 15345'
venue_reception.map_src = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3965.6711805879204!2d106.6495916!3d-6.306860099999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69fb67fc0f1cf9%3A0x49e60e0c1e2a4a78!2sUmatis%20Resto%20%26%20Venue!5e0!3m2!1sen!2sid!4v1744184581722!5m2!1sen!2sid"
venue_reception.start_time = Time.new(2025, 06, 07, 18, 0, 0, 0)
venue_reception.end_time = Time.new(2025, 06, 07, 22, 0, 0, 0)
venue_reception.max_attendees = 50
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
guest1 = Guest.new
guest1.name = "Milky"
guest1.gender = 0
guest1.contact = "085939976117"
guest1.contact_source = 0
guest1.from_groom = true
guest1.save!

guest2 = Guest.new
guest2.name = "Yadi"
guest2.gender = 1
guest2.contact = "williamyadi.96"
guest2.contact_source = 1
guest2.from_groom = true
guest2.save!

# prepare a holy matrimony and reception invitation for guest 1 and guest 2
invitation = Invitation.new
invitation.id = SecureRandom.uuid
invitation.participant = 2
invitation.wedding_id = wedding.id
invitation.attendance_type = Invitation::ATTENDANCE_TYPE_ENUM[:both]
invitation.attending = true
invitation.with_family = false
invitation.comments = "Congrats ya kalian berdua lovebird!!"
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
