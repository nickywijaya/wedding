# spec/services/user_service/retrieve_spec.rb
require 'rails_helper'

RSpec.describe UserService::Retrieve do
  let(:params) { { search: 'test-query' }}

  subject { UserService.retrieve(params) }

  describe '#perform' do
    context 'when success' do
      context 'when params search given' do
        before do
          allow(User).to receive(:where).with("email LIKE ?", "%test-query%").and_return(double)
        end

        it 'should return no error and success retrieve' do
          subject

          expect { subject }.to_not raise_error
        end
      end

      context 'when no params search given' do
        before do
          params[:search] = ''

          allow(User).to receive(:all).and_return(double)
        end

        it 'should return no error and success retrieve' do
          subject

          expect { subject }.to_not raise_error
        end
      end
    end

    context 'when raise error' do
      before do
        params[:search] = ''

        allow(User).to receive(:all).and_raise(StandardError)
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
          expect { subject }.to raise_error UserService::MissingAttributes
        end
      end

      context 'when params[:search] incorrect' do
        let(:params) { { search: true } }

        it 'should raise error' do
          expect { subject }.to raise_error UserService::InvalidServiceParameter
        end
      end
    end
  end
end
