# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

# useful for development
include SecureRandom

# prepare venue
venue = Venue.new
venue.name = 'GBI Basilea Christ Cathedral'
venue.address = 'Jl. Gading Golf Boulevard No.888, Gading, Kec. Serpong, Kabupaten Tangerang, Banten 15332'
venue.map_src = "https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3966.0371310413143!2d106.64307439999999!3d-6.258839399999999!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2e69fb9b62d7f855%3A0x7
6001147a9a1e55d!2sGBI%20Basilea%20Christ%20Cathedral!5e0!3m2!1sen!2sid!4v1738648825850!5m2!1sen!2sid"
venue.start_time = Time.new(2025, 06, 07, 11, 0, 0, 0)
venue.end_time = Time.new(2025, 06, 07, 13, 0, 0, 0)
venue.max_attendees = 70
venue.save!

# prepare wedding
wedding = Weddings.new
wedding.groom = 'Nicky'
wedding.bride = 'Nova'
wedding.story = 'Our love began in 2019 and still feels new all the time.'
wedding.hashtag = '#NickyAndNovaWedding'
wedding.venue_id = venue.id
wedding.save!

# prepare guest list
guest1 = Guest.new
guest1.name = "Milky"
guest1.gender = 0
guest1.save!

guest2 = Guest.new
guest2.name = "Yadi"
guest2.gender = 1
guest2.save!

# prepare an invitation for guest 1 and guest 2
invitation = Invitation.new
invitation.id = SecureRandom.uuid
invitation.participant = 2
invitation.wedding_id = wedding.id
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
