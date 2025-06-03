# spec/services/guest_service/create_spec.rb
require 'rails_helper'

RSpec.describe GuestService::Create do
  let(:params) { { name: 'test-name', gender: 0, contact: 'test-contact', contact_source: 0, from_groom: true } }

  subject { GuestService.create(params) }

  describe '#perform' do
    context 'when success' do
      let(:guest_double)  { double }

      before do
        allow(Guest).to receive(:new).with(params).and_return(guest_double)
        allow(guest_double).to receive(:save!)
      end

      it 'should return no error and success create' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when raise error' do
      before do
        allow(Guest).to receive(:new).with(params).and_raise(StandardError)
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

      context 'when params is not a hash' do
        let(:params) { 'this is not a hash' }

        it 'should raise error' do
          expect { subject }.to raise_error GuestService::InvalidServiceParameter
        end
      end

      context 'when params[:name] is incorrect' do
        before do
          params[:name] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(GuestService::InvalidServiceParameterWithMessage)
            expect(error.message).to eq('Parameter name tidak boleh kosong')
          end
        end
      end

      context 'when params[:gender] is incorrect' do
        before do
          params[:gender] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(GuestService::InvalidServiceParameterWithMessage)
            expect(error.message).to eq('Parameter gender harus dipilih')
          end
        end
      end

      context 'when params[:contact] is incorrect' do
        before do
          params[:contact] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(GuestService::InvalidServiceParameterWithMessage)
            expect(error.message).to eq('Parameter contact tidak boleh kosong')
          end
        end
      end

      context 'when params[:contact_source] is incorrect' do
        before do
          params[:contact_source] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(GuestService::InvalidServiceParameterWithMessage)
            expect(error.message).to eq('Parameter contact_source harus dipilih')
          end
        end
      end

      context 'when params[:from_groom] is incorrect' do
        before do
          params[:from_groom] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(GuestService::InvalidServiceParameterWithMessage)
            expect(error.message).to eq('Parameter guest_relation harus dipilih')
          end
        end
      end

    end
  end
end
