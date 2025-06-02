# spec/models/weddings_spec.rb
require 'rails_helper'

RSpec.describe Guest, type: :model do

  describe 'relation' do
    context 'has_many InvitationGuest' do
      it { should respond_to(:invitation_guests) }
    end

    context 'has_many Invitations through InvitationGuest' do
      it { should respond_to(:invitations) }
    end
  end

  describe '#fetch_gender' do
    let(:subject) { Guest.new(name: 'test', gender: gender) }

    context 'when guest is female' do
      let(:gender) { 0 }

      it 'should return female' do
        expect(subject.fetch_gender).to eq('female')
      end
    end

    context 'when guest is male' do
      let(:gender) { 1 }

      it 'should return male' do
        expect(subject.fetch_gender).to eq('male')
      end
    end
  end

  describe '#fetch_contact_source' do
    let(:subject) { Guest.new(name: 'test', contact_source: source) }

    context 'when source is from whatsapp' do
      let(:source) { 0 }

      it 'should return whatsapp' do
        expect(subject.fetch_contact_source).to eq('whatsapp')
      end
    end

    context 'when source is from instagram' do
      let(:source) { 1 }

      it 'should return instagram' do
        expect(subject.fetch_contact_source).to eq('instagram')
      end
    end

    context 'when source is from tiktok' do
      let(:source) { 2 }

      it 'should return tiktok' do
        expect(subject.fetch_contact_source).to eq('tiktok')
      end
    end
  end

  describe '#fetch_guest_source' do
    let(:subject) { Guest.new(name: 'test', from_groom: from_groom) }

    context 'when source is from groom' do
      let(:from_groom) { true }

      it 'should return groom' do
        expect(subject.fetch_guest_source).to eq('groom')
      end
    end

    context 'when source is from bride' do
      let(:from_groom) { false }

      it 'should return bride' do
        expect(subject.fetch_guest_source).to eq('bride')
      end
    end
  end

  describe '#fetch_invitation' do
    let(:subject) { Guest.new(name: 'test') }
    let(:invitations) { [ Invitation.new(id: '123') ] }

    context 'when invitations is exist' do
      before do
        allow(subject).to receive(:invitations).and_return invitations
      end

      it 'should return correct invitation_id' do
        expect(subject.fetch_invitation).to eq('123')
      end
    end

    context 'when invitations is nil' do
      before do
        allow(subject).to receive(:invitations).and_return []
      end

      it 'should return correct invitation_id' do
        expect(subject.fetch_invitation).to be_nil
      end
    end

  end
end