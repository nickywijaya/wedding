# spec/services/guest_service/delete_spec.rb
require 'rails_helper'

RSpec.describe GuestService::Delete do
  let(:guest) { build_stubbed(:guest) }

  subject { GuestService.delete(guest) }

  describe '#perform' do
    context 'when success' do
      before do
        allow(guest).to receive(:destroy!)
      end

      it 'should return no error and success delete' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when raise error' do
      before do
        allow(guest).to receive(:destroy!).and_raise(StandardError)
      end

      it 'should return error' do
        expect { subject }.to raise_error StandardError
      end
    end
  end

  describe 'validations' do
    context 'raise errors on guest' do
      context 'when guest is nil' do
        let(:guest) { nil }

        it 'should raise error' do
          expect { subject }.to raise_error GuestService::MissingAttributes
        end
      end

      context 'when guest is not a Guest' do
        let(:guest) { 'this is not a Guest' }

        it 'should raise error' do
          expect { subject }.to raise_error GuestService::InvalidServiceParameter
        end
      end
    end
  end
end
