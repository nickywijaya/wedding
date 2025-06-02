# spec/models/invitation_guest_spec.rb
require 'rails_helper'

RSpec.describe InvitationGuest, type: :model do

  describe 'relation' do
    context 'belongs_to Invitation' do
      it { should respond_to(:invitation) }
    end

    context 'belongs_to Guest' do
      it { should respond_to(:guest) }
    end
  end
end