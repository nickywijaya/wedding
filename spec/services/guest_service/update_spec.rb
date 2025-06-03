# spec/services/guest_service/update_spec.rb
require 'rails_helper'

RSpec.describe GuestService::Update do
  let(:guest) { build_stubbed(:guest) }
  let(:params) { { name: 'test-name', gender: 0, contact: 'test-contact', contact_source: 0, from_groom: true } }

  subject { GuestService.update(guest, params) }

  describe '#perform' do
    context 'when success' do
      before do
        allow(guest).to receive(:update).with(params)
        allow(guest).to receive(:save!)
      end

      it 'should return no error and success update' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when raise error' do
      before do
        allow(guest).to receive(:update).and_raise(StandardError)
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
