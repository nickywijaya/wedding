# spec/services/invitation_service/delete_spec.rb
require 'rails_helper'

RSpec.describe InvitationService::Delete do
  let(:invitation) { build_stubbed(:invitation) }

  subject { InvitationService.delete(invitation) }

  describe '#perform' do
    let(:mocked_double) { double }

    context 'when success' do
      before do
        allow(invitation).to receive(:invitation_guests).and_return([mocked_double])
        allow(mocked_double).to receive(:destroy!)

        allow(invitation).to receive(:destroy!)
      end

      it 'should return no error and success delete' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when raise error' do
      before do
        allow(invitation).to receive(:invitation_guests).and_return([mocked_double])
        allow(mocked_double).to receive(:destroy!).and_raise(StandardError)
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

      context 'when invitation is not an Invitatiion' do
        let(:invitation) { 'this is not an Invitatiion' }

        it 'should raise error' do
          expect { subject }.to raise_error InvitationService::InvalidServiceParameter
        end
      end
    end
  end
end
