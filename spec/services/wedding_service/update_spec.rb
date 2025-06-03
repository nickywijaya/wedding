# spec/services/wedding_service/update_spec.rb
require 'rails_helper'

RSpec.describe WeddingService::Update do
  let(:wedding)  { build_stubbed(:wedding) }
  let(:params)   { { story: 'test-story', hashtag: 'test-hashtag' } }

  subject { WeddingService.update(wedding, params) }

  describe '#perform' do
    context 'when success' do
      before do
        allow(wedding).to receive(:update).with(params)
        allow(wedding).to receive(:save!)
      end

      it 'should return no error and success create' do
        subject

        expect { subject }.to_not raise_error
      end
    end

    context 'when raise error' do
      before do
        allow(wedding).to receive(:save!).and_raise(StandardError)
      end

      it 'should return error' do
        expect { subject }.to raise_error StandardError
      end
    end
  end

  describe 'validations' do
    context 'raise errors on venue' do
      context 'when wedding is nil' do
        let(:wedding) { nil }

        it 'should raise error' do
          expect { subject }.to raise_error WeddingService::MissingAttributes
        end
      end

      context 'when wedding is not an Wedding' do
        let(:wedding) { 'this is not a Wedding' }

        it 'should raise error' do
          expect { subject }.to raise_error WeddingService::InvalidServiceParameter
        end
      end
    end

    context 'raise errors on params' do
      context 'when params is nil' do
        let(:params) { nil }

        it 'should raise error' do
          expect { subject }.to raise_error WeddingService::MissingAttributes
        end
      end

      context 'when params is not a hash' do
        let(:params) { 'this is not a hash' }

        it 'should raise error' do
          expect { subject }.to raise_error WeddingService::InvalidServiceParameter
        end
      end

      context 'when params[:hashtag] is incorrect' do
        before do
          params[:hashtag] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(WeddingService::InvalidServiceParameterWithMessage)
            expect(error.message).to eq('Parameter hashtag tidak boleh kosong')
          end
        end
      end

      context 'when params[:story] is incorrect' do
        before do
          params[:story] = nil
        end

        it 'should raise error' do
          expect { subject }.to raise_error do |error|
            expect(error).to be_a(WeddingService::InvalidServiceParameterWithMessage)
            expect(error.message).to eq('Parameter story tidak boleh kosong')
          end
        end
      end

    end
  end
end

