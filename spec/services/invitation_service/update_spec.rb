# spec/services/invitation_service/update_spec.rb
require 'rails_helper'

RSpec.describe InvitationService::Update do
  let(:invitation)  { build_stubbed(:invitation) }
  let(:params)      { { wedding_id: 123, participant: 10, attendance_type: 0, with_family: false, with_partner: false, guest_ids: [1,2,3] } }

  subject { InvitationService.update(invitation, params) }

  describe '#perform' do
    context 'when success with skip update old guests' do
      before do
        allow(invitation).to receive_message_chain(:guests, :pluck).and_return(params[:guest_ids])
        allow(invitation).to receive(:save!)
      end

      it 'should return no error and success create' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when success with update guests' do
      let(:mocked_invitation_guest)  { double }

      before do
        allow(invitation).to receive_message_chain(:guests, :pluck).and_return([4])

        allow(invitation).to receive(:invitation_guests).and_return([mocked_invitation_guest])
        allow(mocked_invitation_guest).to receive(:destroy!)
        allow_any_instance_of(InvitationGuest).to receive(:save!)

        allow(invitation).to receive(:save!)
      end

      it 'should return no error and success create' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when raise error' do
      before do
        allow(invitation).to receive_message_chain(:guests, :pluck).and_return(params[:guest_ids])
        allow(invitation).to receive(:save!).and_raise(StandardError)
      end

      it 'should return error' do
        expect { subject }.to raise_error StandardError
      end
    end
  end

  describe 'validations' do
    context 'raise errors on invitation' do
      context 'when invitation is nil' do
        let(:invitation) { nil }

        it 'should raise error' do
          expect { subject }.to raise_error InvitationService::MissingAttributes
        end
      end

      context 'when invitation is not an Invitation' do
        let(:params) { 'this is not an Invitation' }

        it 'should raise error' do
          expect { subject }.to raise_error InvitationService::InvalidServiceParameter
        end
      end
    end

    context 'raise errors on params' do
      context 'when params is nil' do
        let(:params) { nil }

        it 'should raise error' do
          expect { subject }.to raise_error InvitationService::MissingAttributes
        end
      end

      context 'when params is not a hash' do
        let(:params) { 'this is not a hash' }

        it 'should raise error' do
          expect { subject }.to raise_error InvitationService::InvalidServiceParameter
        end
      end

      context 'when params[:attendance_type] is incorrect' do
        before do
          params[:attendance_type] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(InvitationService::InvalidServiceParameter)
            expect(error.message).to eq('Parameter param_attendance_type tidak valid')
          end
        end
      end

      context 'when params[:wedding_id] is incorrect' do
        before do
          params[:wedding_id] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(InvitationService::WeddingNotFound)
            expect(error.message).to eq('Wedding harus di isi')
          end
        end
      end

      context 'when params[:guest_ids] is incorrect' do
        before do
          params[:guest_ids] = []
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(InvitationService::EmptyGuest)
            expect(error.message).to eq('Tamu tidak boleh kosong')
          end
        end
      end

    end
  end
end
