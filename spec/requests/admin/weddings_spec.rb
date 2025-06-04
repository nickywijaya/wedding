require 'rails_helper'

RSpec.describe 'Admin::WeddingsController', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user)       { create(:user, :confirmed) }
  let(:wedding)    { build_stubbed(:wedding) }

  before do
    sign_in user
    allow_any_instance_of(Admin::WeddingsController).to receive(:render)
  end

  describe 'GET /_adminz/weddings' do
    let(:path)  { '/_adminz/weddings' }

    context 'when success' do
      before do
        allow(Weddings).to receive(:all).and_return([wedding])
      end

      it 'renders the index template' do
        get path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when error' do
      before do
        allow(Weddings).to receive(:all).and_raise(StandardError)
      end

      it 'redirect to admin error page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(admin_error_url)
      end
    end

  end

  describe 'GET /_adminz/weddings/1/edit' do
    let(:path)  { '/_adminz/weddings/1/edit' }

    context 'when success' do
      before do
        allow(Weddings).to receive(:find).and_return(wedding)
      end

      it 'renders the edit template' do
        get path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when error' do
      before do
        allow(Weddings).to receive(:find).and_raise(StandardError)
      end

      it 'redirect to admin index weddings page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(admin_weddings_path)
      end
    end

  end

  describe 'PUT /_adminz/weddings/1' do
    let(:path)  { '/_adminz/weddings/1' }
    let(:params) do
      {
        weddings: {
          hashtag: 'test-hashtag',
          story: 'test-story'
        }
      }
    end

    before do
      allow(Weddings).to receive(:find).and_return(wedding)
    end

    context 'when success' do
      before do
        allow(WeddingService).to receive(:update)
      end

      it 'success and redirect to index page' do
        put path, params: params

        expect(response).to redirect_to(admin_weddings_path)
      end
    end

    context 'when raise WeddingService::WeddingError' do
      before do
        allow(WeddingService).to receive(:update).and_raise(WeddingService::WeddingError)
      end

      it 'redirect to edit admin wedding page' do
        expect(Rails.logger).to receive(:error)

        put path, params: params

        expect(response).to redirect_to(edit_admin_wedding_path)
      end
    end

    context 'when raise StandardError' do
      before do
        allow(WeddingService).to receive(:update).and_raise(StandardError)
      end

      it 'redirect to edit admin wedding page' do
        expect(Rails.logger).to receive(:error)

        put path, params: params

        expect(response).to redirect_to(edit_admin_wedding_path)
      end
    end
  end
end
