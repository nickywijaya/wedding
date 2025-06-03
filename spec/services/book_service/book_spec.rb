# spec/services/book_service/book_spec.rb
require 'rails_helper'

RSpec.describe BookService::Book do
  let(:invitation) { Invitation.new }
  let(:params) { { comments: 'test', attending: true } }

  subject { BookService.book(invitation, params) }

  describe '#perform' do
    context 'when success' do
      before do
        allow(invitation).to receive(:save!).and_return(true)
      end

      it 'updates the invitation with comments and attending' do
        subject

        expect(invitation.comments).to eq(params[:comments])
        expect(invitation.attending).to be true
      end
    end

    context 'when error' do
      before do
        allow(invitation).to receive(:save!).and_raise(StandardError)
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
          expect { subject }.to raise_error BookService::MissingAttributes
        end
      end

      context 'when params is not a hash' do
        let(:params) { 'this is not a hash' }

        it 'should raise error' do
          expect { subject }.to raise_error BookService::InvalidServiceParameter
        end
      end
    end

    context 'raise error on invitation' do
      context 'when invitation is nil' do
        let(:invitation)  { nil }

        it 'should raise error' do
          expect { subject }.to raise_error BookService::MissingAttributes
        end
      end

      context 'when invitation is not an Invitation' do
        let(:invitation)  { 'this is not an Invitation Model' }

        it 'should raise error' do
          expect { subject }.to raise_error BookService::InvalidServiceParameter
        end
      end
    end
  end
end
