# spec/models/weddings_spec.rb
require 'rails_helper'

RSpec.describe Weddings, type: :model do

  describe 'relation' do
    context 'has_many WeddingVenue' do
      it { should respond_to(:wedding_venues) }
    end

    context 'has_many Venue through WeddingVenue' do
      it { should respond_to(:venues) }
    end

    context 'has_many Invitation' do
      it { should respond_to(:invitations) }
    end

    context 'has_many InvitationGuest through Invitation' do
      it { should respond_to(:invitation_guests) }
    end

    context 'has_many Guests through InvitationGuest' do
      it { should respond_to(:guests) }
    end
  end
end