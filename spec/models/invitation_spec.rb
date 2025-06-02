# spec/models/invitation_spec.rb
require 'rails_helper'

RSpec.describe Invitation, type: :model do

  describe 'relation' do
    context 'has_many InvitationGuest' do
      it { should respond_to(:invitation_guests) }
    end

    context 'has_many Guests through InvitationGuest' do
      it { should respond_to(:guests) }
    end

    context 'belongs_to Wedding' do
      it { should respond_to(:wedding) }
    end
  end

  describe '.fetch_filled_comments' do
    let!(:invitation) { create(:invitation, comments: comments) }

    context 'when no comments on database' do
      let(:comments) { nil }

      it 'should return blank data' do
        expect(Invitation.fetch_filled_comments(20)).to eq([])
      end
    end

    context 'when blank comments on database' do
      let(:comments) { '' }

      it 'should return blank data' do
        expect(Invitation.fetch_filled_comments(20)).to eq([])
      end
    end

    context 'when comments exist on database' do
      let(:comments) { 'test' }

      it 'should return correct data' do
        expect(Invitation.fetch_filled_comments(20)).to eq([invitation])
      end
    end
  end

  describe '#fetch_attendance_type' do
    let(:subject) { Invitation.new(wedding_id: 1, attendance_type: attendance_type) }

    context 'when attendance_type is holy_matrimony' do
      let(:attendance_type) { 0 }

      it 'should return Holy Matrimony' do
        expect(subject.fetch_attendance_type).to eq('Holy Matrimony')
      end
    end

    context 'when attendance_type is reception' do
      let(:attendance_type) { 1 }

      it 'should return Reception' do
        expect(subject.fetch_attendance_type).to eq('Reception')
      end
    end

    context 'when attendance_type is both' do
      let(:attendance_type) { 2 }

      it 'should return Both' do
        expect(subject.fetch_attendance_type).to eq('Both')
      end
    end
  end

  describe '#is_holy_matrimony_invited?' do
    let(:subject) { Invitation.new(wedding_id: 1, attendance_type: attendance_type) }

    context 'when attendance_type is holy_matrimony' do
      let(:attendance_type) { 0 }

      it 'should return true' do
        expect(subject.is_holy_matrimony_invited?).to be_truthy
      end
    end

    context 'when attendance_type is reception' do
      let(:attendance_type) { 1 }

      it 'should return false' do
        expect(subject.is_holy_matrimony_invited?).to be_falsey
      end
    end

    context 'when attendance_type is both' do
      let(:attendance_type) { 2 }

      it 'should return true' do
        expect(subject.is_holy_matrimony_invited?).to be_falsey
      end
    end
  end

  describe '#is_reception_invited?' do
    let(:subject) { Invitation.new(wedding_id: 1, attendance_type: attendance_type) }

    context 'when attendance_type is holy_matrimony' do
      let(:attendance_type) { 0 }

      it 'should return true' do
        expect(subject.is_reception_invited?).to be_falsey
      end
    end

    context 'when attendance_type is reception' do
      let(:attendance_type) { 1 }

      it 'should return false' do
        expect(subject.is_reception_invited?).to be_truthy
      end
    end

    context 'when attendance_type is both' do
      let(:attendance_type) { 2 }

      it 'should return true' do
        expect(subject.is_reception_invited?).to be_falsey
      end
    end
  end

  describe '#is_both_events_invited?' do
    let(:subject) { Invitation.new(wedding_id: 1, attendance_type: attendance_type) }

    context 'when attendance_type is holy_matrimony' do
      let(:attendance_type) { 0 }

      it 'should return true' do
        expect(subject.is_both_events_invited?).to be_falsey
      end
    end

    context 'when attendance_type is reception' do
      let(:attendance_type) { 1 }

      it 'should return false' do
        expect(subject.is_both_events_invited?).to be_falsey
      end
    end

    context 'when attendance_type is both' do
      let(:attendance_type) { 2 }

      it 'should return true' do
        expect(subject.is_both_events_invited?).to be_truthy
      end
    end
  end

  describe '#fetch_attending_info' do
    let(:subject) { Invitation.new(wedding_id: 1, attending: attending) }

    context 'when attending is nil' do
      let(:attending) { nil }

      it 'should return correct string' do
        expect(subject.fetch_attending_info).to eq('Not Confirmed')
      end
    end

    context 'when attending is true' do
      let(:attending) { true }

      it 'should return correct string' do
        expect(subject.fetch_attending_info).to eq('Attend')
      end
    end

    context 'when attending is false' do
      let(:attending) { false }

      it 'should return correct string' do
        expect(subject.fetch_attending_info).to eq('Not Attend')
      end
    end
  end

end