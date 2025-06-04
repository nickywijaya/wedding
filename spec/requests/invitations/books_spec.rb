require 'rails_helper'

RSpec.describe 'Invitations::BooksController', type: :request do

  let(:venue)      { create(:venue, :with_guests) }
  let(:wedding)    { venue.weddings.first }
  let(:invitation) { build_stubbed(:invitation, :holy_matrimony) }
  let(:guest)      { build_stubbed(:guest) }

  describe 'GET /invitations/books' do
    let(:path)  { '/invitations/books' }

    context 'when success' do
      before do
        allow(Weddings).to receive(:first).and_return(wedding)
        allow(Invitation).to receive_message_chain(:fetch_filled_comments, :shuffle).and_return([invitation])
      end

      it 'renders the index template' do
        get path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when error' do
      before do
        allow(Weddings).to receive(:first).and_raise(StandardError)
      end

      it 'redirect to public error page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(error_path)
      end
    end

  end

  describe 'GET /invitations/books/123' do
    let(:path)  { '/invitations/books/123' }

    context 'when success' do
      context 'and invitation with partner' do
        before do
          allow(Invitation).to receive(:find).and_return(invitation)
          allow(invitation).to receive(:guests).and_return([guest])

          allow(invitation).to receive(:with_partner?).and_return(true)
          allow(invitation).to receive(:wedding).and_return(wedding)

          allow(Invitation).to receive_message_chain(:fetch_filled_comments, :shuffle).and_return([invitation])
        end

        it 'renders the index template' do
          get path
          expect(response).to have_http_status(:ok)
        end
      end

      context 'and invitation with family' do
        before do
          allow(Invitation).to receive(:find).and_return(invitation)
          allow(invitation).to receive(:guests).and_return([guest])

          allow(invitation).to receive(:with_partner?).and_return(false)
          allow(invitation).to receive(:with_family?).and_return(true)
          allow(invitation).to receive(:wedding).and_return(wedding)

          allow(Invitation).to receive_message_chain(:fetch_filled_comments, :shuffle).and_return([invitation])
        end

        it 'renders the index template' do
          get path
          expect(response).to have_http_status(:ok)
        end
      end

      context 'and invitation without family / partner' do
        before do
          allow(Invitation).to receive(:find).and_return(invitation)
          allow(invitation).to receive(:guests).and_return([guest])

          allow(invitation).to receive(:with_partner?).and_return(false)
          allow(invitation).to receive(:with_family?).and_return(false)
          allow(invitation).to receive(:wedding).and_return(wedding)

          allow(Invitation).to receive_message_chain(:fetch_filled_comments, :shuffle).and_return([invitation])
        end

        it 'renders the index template' do
          get path
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when error on load_resource' do
      before do
        allow(Invitation).to receive(:find).and_raise(StandardError)
      end

      it 'redirect to public error page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(error_path)
      end
    end

    context 'when error' do
      before do
        allow(Invitation).to receive(:find).and_return(invitation)
        allow(invitation).to receive(:guests).and_raise(StandardError)
      end

      it 'redirect to public error page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(error_path)
      end
    end

  end

  describe 'POST /invitations/books/123' do
    let(:path)  { '/invitations/books/123' }
    let(:params) do
      {
        comments: 'test-comment',
        attending: true
      }
    end

    context 'when success' do
      before do
        allow(Invitation).to receive(:find).and_return(invitation)
        allow(BookService).to receive(:book)
      end

      it 'renders the index template' do
        post path, params: params

        expect(response).to redirect_to(invitations_show_path(invitation))
      end
    end

    context 'when error' do
      before do
        allow(Invitation).to receive(:find).and_return(invitation)
        allow(BookService).to receive(:book).and_raise(StandardError)
      end

      it 'redirect to public error page' do
        expect(Rails.logger).to receive(:error)

        post path, params: params

        expect(response).to redirect_to(error_path)
      end
    end

  end
end
