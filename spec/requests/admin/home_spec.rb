require 'rails_helper'

RSpec.describe 'Admin::HomeController', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user)  { create(:user, :confirmed) }
  let(:venue_holy_matrimony)  { create(:venue, :with_guests) }
  let(:venue_reception)       { create(:venue, :reception, :with_guests) }
  let(:wedding)               { venue_holy_matrimony.weddings.first }

  let(:invitation) { build_stubbed(:invitation, :holy_matrimony) }
  let(:guest)      { build_stubbed(:guest) }

  before do
    sign_in user
    allow_any_instance_of(Admin::HomeController).to receive(:render)
  end

  describe 'GET /_adminz' do
    let(:path)  { '/_adminz' }

    context 'when success' do
      before do

        allow(Weddings).to receive(:first).and_return(wedding)
        allow(wedding).to receive_message_chain(:venues, :holy_matrimony).and_return(venue_holy_matrimony)
        allow(wedding).to receive_message_chain(:venues, :reception).and_return(venue_reception)
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

      it 'redirect to admin error page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(admin_error_url)
      end
    end
  end

  describe 'GET /_adminz/error' do
    before do
      allow_any_instance_of(ActionDispatch::Request).to receive(:session) { { error_message: 'test-error', error_backtrace: ['line_1'] } }
    end

    it 'renders error message and backtrace from session' do
      get '/_adminz/error'

      expect(response).to have_http_status(:ok)
    end
  end
end
