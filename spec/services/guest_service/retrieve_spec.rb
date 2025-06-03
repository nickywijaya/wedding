# spec/services/guest_service/delete_spec.rb
require 'rails_helper'

RSpec.describe GuestService::Retrieve do
  let(:params) { { search: 'test-query', guest_source: 'groom'} }

  subject { GuestService.retrieve(params) }

  describe '#perform' do
    let(:mock_relation) { instance_double(ActiveRecord::Relation) }

    context 'when params[:guest_source] is not present' do
      before do
        params[:guest_source] = nil

        allow(Guest).to receive(:all).and_return(mock_relation)

        allow(mock_relation).to receive(:where).with('name ILIKE ?', '%test-query%').and_return(mock_relation)
      end

      it 'should return no error and success retrieve' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when params[:search] is not present' do
      before do
        params[:search] = ''

        allow(Guest).to receive(:all).and_return(mock_relation)

        allow(mock_relation).to receive(:where).with('from_groom = ?', true).and_return(mock_relation)
      end

      it 'should return no error and success retrieve' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when both params is not provided' do
      before do
        params[:search] = ''
        params[:guest_source] = nil

        allow(Guest).to receive(:all).and_return(mock_relation)
      end

      it 'should return no error and success retrieve' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when both params is provided' do
      before do
        allow(Guest).to receive(:all).and_return(mock_relation)

        allow(mock_relation).to receive(:where).with('name ILIKE ?', '%test-query%').and_return(mock_relation)
        allow(mock_relation).to receive(:where).with('from_groom = ?', true).and_return(mock_relation)
      end

      it 'should return no error and success retrieve' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when raise error' do
      before do
        allow(Guest).to receive(:all).and_raise(StandardError)
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
          expect { subject }.to raise_error GuestService::MissingAttributes
        end
      end

      context 'when params[:search] is not a string' do
        let(:params) { { search: true } }

        it 'should raise error' do
          expect { subject }.to raise_error GuestService::InvalidServiceParameter
        end
      end
    end
  end
end
