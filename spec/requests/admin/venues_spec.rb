require 'rails_helper'

RSpec.describe 'Admin::VenuesController', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user)       { create(:user, :confirmed) }
  let(:venue)      { build_stubbed(:venue) }

  before do
    sign_in user
  end

  describe 'GET /_adminz/venues' do
    let(:path)  { '/_adminz/venues' }

    context 'when success' do
      before do
        allow(Venue).to receive(:all).and_return([venue])
      end

      it 'renders the index template' do
        get path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when error' do
      before do
        allow(Venue).to receive(:all).and_raise(StandardError)
      end

      it 'redirect to admin error page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(admin_error_url)
      end
    end

  end

  describe 'GET /_adminz/venues/1/edit' do
    let(:path)  { '/_adminz/venues/1/edit' }

    context 'when success' do
      before do
        allow(Venue).to receive(:find).and_return(venue)
      end

      it 'renders the edit template' do
        get path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when error' do
      before do
        allow(Venue).to receive(:find).and_raise(StandardError)
      end

      it 'redirect to admin index venues page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(admin_venues_path)
      end
    end

  end

  describe 'PUT /_adminz/venues/1' do
    let(:path)  { '/_adminz/venues/1' }
    let(:params) do
      {
        venue: {
          name: 'test-name',
          address: 'test-address',
          map_src: 'test-map_src',
          max_attendees: 100,
          venue_type: Venue::VENUE_TYPE_ENUM[:reception]
        }
      }
    end

    before do
      allow(Venue).to receive(:find).and_return(venue)
    end

    context 'when success' do
      before do
        allow(VenueService).to receive(:update)
      end

      it 'success and redirect to index page' do
        put path, params: params

        expect(response).to redirect_to(admin_venues_path)
      end
    end

    context 'when raise VenueService::VenueError' do
      before do
        allow(VenueService).to receive(:update).and_raise(VenueService::VenueError)
      end

      it 'redirect to edit admin venue page' do
        expect(Rails.logger).to receive(:error)

        put path, params: params

        expect(response).to redirect_to(edit_admin_venue_path)
      end
    end

    context 'when raise StandardError' do
      before do
        allow(VenueService).to receive(:update).and_raise(StandardError)
      end

      it 'redirect to edit admin venue page' do
        expect(Rails.logger).to receive(:error)

        put path, params: params

        expect(response).to redirect_to(edit_admin_venue_path)
      end
    end
  end
end
