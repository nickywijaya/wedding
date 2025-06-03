# spec/services/invitation_service/create_spec.rb
require 'rails_helper'

RSpec.describe InvitationService::Create do
  let(:params) { { wedding_id: 123, participant: 10, attendance_type: 0, with_family: false, with_partner: false, guest_ids: [1,2,3] } }

  subject { InvitationService.create(params) }

  describe '#perform' do
    context 'when success' do
      let(:guest_double)  { double }

      before do
        allow_any_instance_of(Invitation).to receive(:save!)
        allow_any_instance_of(InvitationGuest).to receive(:save!)
      end

      it 'should return no error and success create' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when raise error' do
      before do
        allow(Invitation).to receive(:new).and_raise(StandardError)
      end

      it 'should return error' do
        expect { subject }.to raise_error StandardError
      end
    end
  end

  describe 'validations' do
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

      context 'when params[:wedding_id] is incorrect' do
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
