# spec/services/venue_service/update_spec.rb
require 'rails_helper'

RSpec.describe VenueService::Update do
  let(:venue)  { build_stubbed(:venue) }
  let(:params) { { name: 'test-name', address: 'test-address', map_src: 'test-map-src', max_attendees: 100, venue_type: Venue::VENUE_TYPE_ENUM[:holy_matrimony]} }

  subject { VenueService.update(venue, params) }

  describe '#perform' do
    context 'when success' do
      before do
        allow(venue).to receive(:update).with(params)
        allow(venue).to receive(:save!)
      end

      it 'should return no error and success create' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when raise error' do
      before do
        allow(venue).to receive(:save!).and_raise(StandardError)
      end

      it 'should return error' do
        expect { subject }.to raise_error StandardError
      end
    end
  end

  describe 'validations' do
    context 'raise errors on venue' do
      context 'when venue is nil' do
        let(:venue) { nil }

        it 'should raise error' do
          expect { subject }.to raise_error VenueService::MissingAttributes
        end
      end

      context 'when venue is not a Venue' do
        let(:venue) { 'this is not a Venue' }

        it 'should raise error' do
          expect { subject }.to raise_error VenueService::InvalidServiceParameter
        end
      end
    end

    context 'raise errors on params' do
      context 'when params is nil' do
        let(:params) { nil }

        it 'should raise error' do
          expect { subject }.to raise_error VenueService::MissingAttributes
        end
      end

      context 'when params is not a hash' do
        let(:params) { 'this is not a hash' }

        it 'should raise error' do
          expect { subject }.to raise_error VenueService::InvalidServiceParameter
        end
      end

      context 'when params[:name] is incorrect' do
        before do
          params[:name] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(VenueService::InvalidServiceParameterWithMessage)
            expect(error.message).to eq('Parameter name tidak boleh kosong')
          end
        end
      end

      context 'when params[:address] is incorrect' do
        before do
          params[:address] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(VenueService::InvalidServiceParameterWithMessage)
            expect(error.message).to eq('Parameter address tidak boleh kosong')
          end
        end
      end

      context 'when params[:map_src] is incorrect' do
        before do
          params[:map_src] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(VenueService::InvalidServiceParameterWithMessage)
            expect(error.message).to eq('Parameter map_src tidak boleh kosong')
          end
        end
      end

      context 'when params[:max_attendees] is incorrect' do
        before do
          params[:max_attendees] = 0
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(VenueService::InvalidServiceParameterWithMessage)
            expect(error.message).to eq('Parameter max_attendees harus lebih dari 0')
          end
        end
      end

      context 'when params[:venue_type] is incorrect' do
        before do
          params[:venue_type] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(VenueService::InvalidServiceParameterWithMessage)
            expect(error.message).to eq('Parameter venue_type tidak boleh kosong')
          end
        end
      end

    end
  end
end

