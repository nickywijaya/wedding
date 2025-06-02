# spec/models/venue_spec.rb
require 'rails_helper'

RSpec.describe Venue, type: :model do

  describe 'relation' do
    context 'has_many WeddingVenues' do
      it { should respond_to(:wedding_venues) }
    end

    context 'has_many Weddings through WeddingVenues' do
      it { should respond_to(:weddings) }
    end

    context 'has_many Invitations through Weddings' do
      it { should respond_to(:invitations) }
    end

    context 'has_many InvitationGuests through Invitations' do
      it { should respond_to(:invitation_guests) }
    end

    context 'has_many Guests through InvitationGuests' do
      it { should respond_to(:guests) }
    end
  end

  describe '#fetch_venue_type' do
    let(:subject) { Venue.new(name: 'test-venue', venue_type: venue_type) }

    context 'when venue_type is holy_matrimony' do
      let(:venue_type) { 0 }

      it 'should return Holy Matrimony' do
        expect(subject.fetch_venue_type).to eq('Holy Matrimony')
      end
    end

    context 'when venue_type is reception' do
      let(:venue_type) { 1 }

      it 'should return Reception' do
        expect(subject.fetch_venue_type).to eq('Reception')
      end
    end
  end

  describe '#fetch_aggregated_attendees' do
    let(:invitation_count) { 10 }
    let(:invitation_participant) { 3 }
    let(:expected_result) { invitation_count * invitation_participant }

    let(:venue) { create(:venue, :with_guests, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

    context 'when venue_type is holy_matrimony' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:holy_matrimony] }

      context 'when invitation type is both' do
        let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

        it 'should return correct attendees number' do
          expect(venue.fetch_aggregated_attendees).to eq(expected_result)
        end
      end

      context 'when invitation type is holy_matrimony' do
        let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

        it 'should return correct attendees number' do
          expect(venue.fetch_aggregated_attendees).to eq(expected_result)
        end
      end

      context 'when invitation type is reception' do
        let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

        it 'should return correct attendees number' do
          expect(venue.fetch_aggregated_attendees).to eq(0)
        end
      end
    end

    context 'when venue_type is holy_matrimony' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:reception] }

      context 'when invitation type is both' do
        let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

        it 'should return correct attendees number' do
          expect(venue.fetch_aggregated_attendees).to eq(expected_result)
        end
      end

      context 'when invitation type is holy_matrimony' do
        let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

        it 'should return correct attendees number' do
          expect(venue.fetch_aggregated_attendees).to eq(0)
        end
      end

      context 'when invitation type is reception' do
        let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

        it 'should return correct attendees number' do
          expect(venue.fetch_aggregated_attendees).to eq(expected_result)
        end
      end
    end
  end

  describe '#fetch_attended_attendees' do
    let(:invitation_count) { 10 }
    let(:invitation_participant) { 3 }
    let(:expected_result) { invitation_count * invitation_participant }

    context 'when venue_type is holy_matrimony' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:holy_matrimony] }

      context 'when half guest is not attending' do
        let(:venue) { create(:venue, :with_guests_half_attending, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct attendees number' do
            expect(venue.fetch_attended_attendees).to eq(expected_result / 2)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct attendees number' do
            expect(venue.fetch_attended_attendees).to eq(expected_result / 2)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct attendees number' do
            expect(venue.fetch_attended_attendees).to eq(0)
          end
        end
      end

      context 'when all guest is attending' do
        let(:venue) { create(:venue, :with_all_guests_attending, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct attendees number' do
            expect(venue.fetch_attended_attendees).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct attendees number' do
            expect(venue.fetch_attended_attendees).to eq(expected_result)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct attendees number' do
            expect(venue.fetch_attended_attendees).to eq(0)
          end
        end
      end
    end

    context 'when venue_type is reception' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:reception] }

      context 'when half guest is not attending' do
        let(:venue) { create(:venue, :with_guests_half_attending, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct attendees number' do
            expect(venue.fetch_attended_attendees).to eq(expected_result / 2)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct attendees number' do
            expect(venue.fetch_attended_attendees).to eq(expected_result / 2)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct attendees number' do
            expect(venue.fetch_attended_attendees).to eq(0)
          end
        end
      end

      context 'when all guest is attending' do
        let(:venue) { create(:venue, :with_all_guests_attending, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct attendees number' do
            expect(venue.fetch_attended_attendees).to eq(expected_result)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct attendees number' do
            expect(venue.fetch_attended_attendees).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct attendees number' do
            expect(venue.fetch_attended_attendees).to eq(0)
          end
        end
      end
    end
  end

  describe '#fetch_absent_attendees' do
    let(:invitation_count) { 10 }
    let(:invitation_participant) { 3 }

    context 'when venue_type is holy_matrimony' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:holy_matrimony] }
      let(:expected_result) { invitation_count * invitation_participant }

      context 'when half guest is not attending' do
        let(:venue) { create(:venue, :with_guests_half_attending, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct attendees number' do
            expect(venue.fetch_absent_attendees).to eq(expected_result / 2)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct attendees number' do
            expect(venue.fetch_absent_attendees).to eq(expected_result / 2)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct attendees number' do
            expect(venue.fetch_absent_attendees).to eq(0)
          end
        end
      end

      context 'when all guest is attending' do
        let(:venue) { create(:venue, :with_all_guests_attending, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

        let(:expected_result) { 0 }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct attendees number' do
            expect(venue.fetch_absent_attendees).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct attendees number' do
            expect(venue.fetch_absent_attendees).to eq(expected_result)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct attendees number' do
            expect(venue.fetch_absent_attendees).to eq(expected_result)
          end
        end
      end
    end

    context 'when venue_type is reception' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:reception] }

      context 'when half guest is not attending' do
        let(:venue) { create(:venue, :with_guests_half_attending, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

        let(:expected_result) { invitation_count * invitation_participant }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct attendees number' do
            expect(venue.fetch_absent_attendees).to eq(expected_result / 2)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct attendees number' do
            expect(venue.fetch_absent_attendees).to eq(expected_result / 2)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct attendees number' do
            expect(venue.fetch_absent_attendees).to eq(0)
          end
        end
      end

      context 'when all guest is attending' do
        let(:venue) { create(:venue, :with_all_guests_attending, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

        let(:expected_result) { 0 }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct attendees number' do
            expect(venue.fetch_absent_attendees).to eq(expected_result)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct attendees number' do
            expect(venue.fetch_absent_attendees).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct attendees number' do
            expect(venue.fetch_absent_attendees).to eq(expected_result)
          end
        end
      end
    end
  end

  describe '#fetch_not_confirmed_attendees' do
    let(:invitation_count) { 10 }
    let(:invitation_participant) { 3 }

    context 'when venue_type is holy_matrimony' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:holy_matrimony] }
      let(:expected_result) { invitation_count * invitation_participant }

      context 'when half guest is not confirmed' do
        let(:venue) { create(:venue, :with_guests_half_confirmed, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct attendees number' do
            expect(venue.fetch_not_confirmed_attendees).to eq(expected_result / 2)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct attendees number' do
            expect(venue.fetch_not_confirmed_attendees).to eq(expected_result / 2)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct attendees number' do
            expect(venue.fetch_not_confirmed_attendees).to eq(0)
          end
        end
      end

      context 'when all guest is attending' do
        let(:venue) { create(:venue, :with_all_guests_attending, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

        let(:expected_result) { 0 }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct attendees number' do
            expect(venue.fetch_not_confirmed_attendees).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct attendees number' do
            expect(venue.fetch_not_confirmed_attendees).to eq(expected_result)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct attendees number' do
            expect(venue.fetch_not_confirmed_attendees).to eq(expected_result)
          end
        end
      end
    end

    context 'when venue_type is reception' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:reception] }

      context 'when half guest is not confirmed' do
        let(:venue) { create(:venue, :with_guests_half_confirmed, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

        let(:expected_result) { invitation_count * invitation_participant }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct attendees number' do
            expect(venue.fetch_not_confirmed_attendees).to eq(expected_result / 2)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct attendees number' do
            expect(venue.fetch_not_confirmed_attendees).to eq(expected_result / 2)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct attendees number' do
            expect(venue.fetch_not_confirmed_attendees).to eq(0)
          end
        end
      end

      context 'when all guest is attending' do
        let(:venue) { create(:venue, :with_all_guests_attending, venue_type: venue_type, invitation_count: invitation_count, invitation_participant: invitation_participant, attendance_type: attendance_type) }

        let(:expected_result) { 0 }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct attendees number' do
            expect(venue.fetch_not_confirmed_attendees).to eq(expected_result)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct attendees number' do
            expect(venue.fetch_not_confirmed_attendees).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct attendees number' do
            expect(venue.fetch_not_confirmed_attendees).to eq(expected_result)
          end
        end
      end
    end
  end

  describe '#fetch_not_sent_invitation' do
    let(:invitation_count) { 10 }

    context 'when venue_type is holy_matrimony' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:holy_matrimony] }

      context 'when half invitation is not sent' do
        let(:venue)           { create(:venue, :with_invitation_half_sent, venue_type: venue_type, invitation_count: invitation_count,  attendance_type: attendance_type) }
        let(:expected_result) { invitation_count }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct invitation number' do
            expect(venue.fetch_not_sent_invitation).to eq(expected_result / 2)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct invitation number' do
            expect(venue.fetch_not_sent_invitation).to eq(expected_result / 2)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct invitation number' do
            expect(venue.fetch_not_sent_invitation).to eq(0)
          end
        end
      end

      context 'when all invitation is sent' do
        let(:venue)           { create(:venue, :with_invitation_all_sent, venue_type: venue_type, invitation_count: invitation_count,  attendance_type: attendance_type) }
        let(:expected_result) { 0 }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct invitation number' do
            expect(venue.fetch_not_sent_invitation).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct invitation number' do
            expect(venue.fetch_not_sent_invitation).to eq(expected_result)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct invitation number' do
            expect(venue.fetch_not_sent_invitation).to eq(expected_result)
          end
        end
      end
    end

    context 'when venue_type is reception' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:reception] }

      context 'when half invitation is not sent' do
        let(:venue)           { create(:venue, :with_invitation_half_sent, venue_type: venue_type, invitation_count: invitation_count,  attendance_type: attendance_type) }
        let(:expected_result) { invitation_count }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct invitation number' do
            expect(venue.fetch_not_sent_invitation).to eq(expected_result / 2)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct invitation number' do
            expect(venue.fetch_not_sent_invitation).to eq(expected_result / 2)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct invitation number' do
            expect(venue.fetch_not_sent_invitation).to eq(0)
          end
        end
      end

      context 'when all invitation is sent' do
        let(:venue)           { create(:venue, :with_invitation_all_sent, venue_type: venue_type, invitation_count: invitation_count,  attendance_type: attendance_type) }
        let(:expected_result) { 0 }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct invitation number' do
            expect(venue.fetch_not_sent_invitation).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct invitation number' do
            expect(venue.fetch_not_sent_invitation).to eq(expected_result)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct invitation number' do
            expect(venue.fetch_not_sent_invitation).to eq(expected_result)
          end
        end
      end
    end
  end

  describe '#fetch_sent_invitation' do
    let(:invitation_count) { 10 }

    context 'when venue_type is holy_matrimony' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:holy_matrimony] }

      context 'when half invitation is not sent' do
        let(:venue)           { create(:venue, :with_invitation_half_sent, venue_type: venue_type, invitation_count: invitation_count,  attendance_type: attendance_type) }
        let(:expected_result) { invitation_count }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct invitation number' do
            expect(venue.fetch_sent_invitation).to eq(expected_result / 2)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct invitation number' do
            expect(venue.fetch_sent_invitation).to eq(expected_result / 2)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct invitation number' do
            expect(venue.fetch_sent_invitation).to eq(0)
          end
        end
      end

      context 'when all invitation is sent' do
        let(:venue)           { create(:venue, :with_invitation_all_sent, venue_type: venue_type, invitation_count: invitation_count,  attendance_type: attendance_type) }
        let(:expected_result) { invitation_count }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct invitation number' do
            expect(venue.fetch_sent_invitation).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct invitation number' do
            expect(venue.fetch_sent_invitation).to eq(expected_result)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct invitation number' do
            expect(venue.fetch_sent_invitation).to eq(0)
          end
        end
      end
    end

    context 'when venue_type is reception' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:reception] }

      context 'when half invitation is not sent' do
        let(:venue)           { create(:venue, :with_invitation_half_sent, venue_type: venue_type, invitation_count: invitation_count,  attendance_type: attendance_type) }
        let(:expected_result) { invitation_count }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct invitation number' do
            expect(venue.fetch_sent_invitation).to eq(expected_result / 2)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct invitation number' do
            expect(venue.fetch_sent_invitation).to eq(expected_result / 2)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct invitation number' do
            expect(venue.fetch_sent_invitation).to eq(0)
          end
        end
      end

      context 'when all invitation is sent' do
        let(:venue)           { create(:venue, :with_invitation_all_sent, venue_type: venue_type, invitation_count: invitation_count,  attendance_type: attendance_type) }
        let(:expected_result) { invitation_count }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct invitation number' do
            expect(venue.fetch_sent_invitation).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct invitation number' do
            expect(venue.fetch_sent_invitation).to eq(0)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct invitation number' do
            expect(venue.fetch_sent_invitation).to eq(expected_result)
          end
        end
      end
    end
  end

  describe '#fetch_total_invitations' do
    let(:invitation_count) { 10 }

    context 'when venue_type is holy_matrimony' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:holy_matrimony] }

      context 'when half invitation is not sent' do
        let(:venue)           { create(:venue, :with_invitation_half_sent, venue_type: venue_type, invitation_count: invitation_count,  attendance_type: attendance_type) }
        let(:expected_result) { invitation_count }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct invitation number' do
            expect(venue.fetch_total_invitations).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct invitation number' do
            expect(venue.fetch_total_invitations).to eq(expected_result)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct invitation number' do
            expect(venue.fetch_total_invitations).to eq(0)
          end
        end
      end

      context 'when all invitation is sent' do
        let(:venue)           { create(:venue, :with_invitation_all_sent, venue_type: venue_type, invitation_count: invitation_count,  attendance_type: attendance_type) }
        let(:expected_result) { invitation_count }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct invitation number' do
            expect(venue.fetch_total_invitations).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct invitation number' do
            expect(venue.fetch_total_invitations).to eq(expected_result)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct invitation number' do
            expect(venue.fetch_total_invitations).to eq(0)
          end
        end
      end
    end

    context 'when venue_type is reception' do
      let(:venue_type) { Venue::VENUE_TYPE_ENUM[:reception] }

      context 'when half invitation is not sent' do
        let(:venue)           { create(:venue, :with_invitation_half_sent, venue_type: venue_type, invitation_count: invitation_count,  attendance_type: attendance_type) }
        let(:expected_result) { invitation_count }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct invitation number' do
            expect(venue.fetch_total_invitations).to eq(expected_result)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct invitation number' do
            expect(venue.fetch_total_invitations).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct invitation number' do
            expect(venue.fetch_total_invitations).to eq(0)
          end
        end
      end

      context 'when all invitation is sent' do
        let(:venue)           { create(:venue, :with_invitation_all_sent, venue_type: venue_type, invitation_count: invitation_count,  attendance_type: attendance_type) }
        let(:expected_result) { invitation_count }

        context 'when invitation is both' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:both] }

          it 'should return correct invitation number' do
            expect(venue.fetch_total_invitations).to eq(expected_result)
          end
        end

        context 'when invitation is holy_matrimony' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] }

          it 'should return correct invitation number' do
            expect(venue.fetch_total_invitations).to eq(0)
          end
        end

        context 'when invitation is reception' do
          let(:attendance_type) { Invitation::ATTENDANCE_TYPE_ENUM[:reception] }

          it 'should return correct invitation number' do
            expect(venue.fetch_total_invitations).to eq(expected_result)
          end
        end
      end
    end
  end
end