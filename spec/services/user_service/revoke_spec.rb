# spec/services/user_service/revoke_spec.rb
require 'rails_helper'

RSpec.describe UserService::Revoke do
  let(:user) { build_stubbed(:user) }

  subject { UserService.revoke(user) }

  describe '#perform' do
    context 'when success' do
      before do
        allow(user).to receive(:save!)
      end

      it 'should return no error and success revoke' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when raise error' do
      before do
        allow(user).to receive(:save!).and_raise(StandardError)
      end

      it 'should return error' do
        expect { subject }.to raise_error StandardError
      end
    end
  end

  describe 'validations' do
    context 'raise errors on user' do
      context 'when user is nil' do
        let(:user) { nil }

        it 'should raise error' do
          expect { subject }.to raise_error UserService::MissingAttributes
        end
      end

      context 'when user is not an User' do
        let(:user) { 'this is not an User' }

        it 'should raise error' do
          expect { subject }.to raise_error UserService::InvalidServiceParameter
        end
      end
    end
  end
end
