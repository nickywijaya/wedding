require 'rails_helper'

RSpec.describe 'Admin::GuestsController', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user)   { create(:user, :confirmed) }
  let!(:guest) { build_stubbed(:guest) }

  before do
    sign_in user
  end

  describe 'GET /_adminz/guests' do
    let(:path)  { '/_adminz/guests' }

    context 'when success' do
      before do
        allow(GuestService).to receive(:retrieve).and_return([guest])
      end

      it 'renders the index template' do
        get path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when error' do
      before do
        allow(GuestService).to receive(:retrieve).and_raise(StandardError)
      end

      it 'redirect to admin error page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(admin_error_url)
      end
    end

  end

  describe 'GET /_adminz/guests/new' do
    let(:path)  { '/_adminz/guests/new' }

    context 'when success' do
      it 'renders the new template' do
        get path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when error' do
      before do
        allow(Guest).to receive(:new).and_raise(StandardError)
      end

      it 'redirect to admin error page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(admin_guests_path)
      end
    end

  end

  describe 'POST /_adminz/guests' do
    let(:path)  { '/_adminz/guests' }
    let(:params) do
      {
        guest: {
          name: 'test-name',
          gender: 0,
          contact: 'test-contact',
          contact_source: 0,
          from_groom: true
        }
      }
    end

    context 'when success' do
      before do
        allow(GuestService).to receive(:create)
      end

      it 'success and redirect to index page' do
        post path, params: params

        expect(response).to redirect_to(admin_guests_path)
      end
    end

    context 'when raise GuestService::GuestError' do
      before do
        allow(GuestService).to receive(:create).and_raise(GuestService::GuestError)
      end

      it 'redirect to new admin guest page' do
        expect(Rails.logger).to receive(:error)

        post path, params: params

        expect(response).to redirect_to(new_admin_guest_path)
      end
    end

    context 'when raise StandardError' do
      before do
        allow(GuestService).to receive(:create).and_raise(StandardError)
      end

      it 'redirect to new admin guest page' do
        expect(Rails.logger).to receive(:error)

        post path, params: params

        expect(response).to redirect_to(new_admin_guest_path)
      end
    end

  end

  describe 'GET /_adminz/guests/1/edit' do
    let(:path)  { '/_adminz/guests/1/edit' }

    context 'when success' do
      before do
        allow(Guest).to receive(:find).and_return(guest)
      end

      it 'renders the edit template' do
        get path

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when error' do
      before do
        allow(Guest).to receive(:find).and_raise(StandardError)
      end

      it 'redirect to admin error page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(admin_guests_path)
      end
    end

  end

  describe 'PUT /_adminz/guests/1' do
    let(:path)  { '/_adminz/guests/1' }
    let(:params) do
      {
        guest: {
          name: 'test-name',
          gender: 0,
          contact: 'test-contact',
          contact_source: 0,
          from_groom: true
        }
      }
    end

    before do
      allow(Guest).to receive(:find).and_return(guest)
    end

    context 'when success' do
      before do
        allow(GuestService).to receive(:update)
      end

      it 'success and redirect to index page' do
        put path, params: params

        expect(response).to redirect_to(admin_guests_path)
      end
    end

    context 'when raise GuestService::GuestError' do
      before do
        allow(GuestService).to receive(:update).and_raise(GuestService::GuestError)
      end

      it 'redirect to edit admin guest page' do
        expect(Rails.logger).to receive(:error)

        put path, params: params

        expect(response).to redirect_to(edit_admin_guest_path)
      end
    end

    context 'when raise StandardError' do
      before do
        allow(GuestService).to receive(:update).and_raise(StandardError)
      end

      it 'redirect to edit admin guest page' do
        expect(Rails.logger).to receive(:error)

        put path, params: params

        expect(response).to redirect_to(edit_admin_guest_path)
      end
    end

  end

  describe 'DELETE /_adminz/guests/1' do
    let(:path)  { '/_adminz/guests/1' }

    before do
      allow(Guest).to receive(:find).and_return(guest)
    end

    context 'when success' do
      before do
        allow(GuestService).to receive(:delete)
      end

      it 'success and redirect to index page' do
        delete path

        expect(response).to redirect_to(admin_guests_path)
      end
    end

    context 'when raise StandardError' do
      before do
        allow(GuestService).to receive(:delete).and_raise(StandardError)
      end

      it 'redirect to index admin guest page' do
        expect(Rails.logger).to receive(:error)

        delete path

        expect(response).to redirect_to(admin_guests_path)
      end
    end

  end
end
