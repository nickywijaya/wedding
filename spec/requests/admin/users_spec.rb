require 'rails_helper'

RSpec.describe 'Admin::UsersController', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user)       { create(:user, :confirmed) }

  before do
    sign_in user
    allow_any_instance_of(Admin::UsersController).to receive(:render)
  end

  describe 'GET /_adminz/users' do
    let(:path)  { '/_adminz/users' }

    context 'when success' do
      before do
        allow(UserService).to receive(:retrieve).and_return([user])
      end

      it 'renders the index template' do
        get path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when error' do
      before do
        allow(UserService).to receive(:retrieve).and_raise(StandardError)
      end

      it 'redirect to admin error page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(admin_error_url)
      end
    end
  end

  describe 'PATCH /_adminz/users/1/confirm' do
    let(:path)  { '/_adminz/users/1/confirm' }

    before do
      allow(User).to receive(:find).and_return(user)
    end

    context 'when success' do
      before do
        allow(UserService).to receive(:confirm)
      end

      it 'redirect to the index user page' do
        expect(Rails.logger).to_not receive(:error)

        patch path

        expect(response).to redirect_to(admin_users_path)
      end
    end

    context 'when error' do
      before do
        allow(UserService).to receive(:confirm).and_raise(StandardError)
      end

      it 'redirect to admin index users page' do
        expect(Rails.logger).to receive(:error)

        patch path

        expect(response).to redirect_to(admin_users_path)
      end
    end
  end

  describe 'PATCH /_adminz/users/1/revoke' do
    let(:path)  { '/_adminz/users/1/revoke' }

    before do
      allow(User).to receive(:find).and_return(user)
    end

    context 'when success' do
      before do
        allow(UserService).to receive(:revoke)
      end

      it 'redirect to the index user page' do
        expect(Rails.logger).to_not receive(:error)

        patch path

        expect(response).to redirect_to(admin_users_path)
      end
    end

    context 'when error' do
      before do
        allow(UserService).to receive(:revoke).and_raise(StandardError)
      end

      it 'redirect to admin index users page' do
        expect(Rails.logger).to receive(:error)

        patch path

        expect(response).to redirect_to(admin_users_path)
      end
    end
  end

  describe 'DELETE /_adminz/users/1' do
    let(:path)  { '/_adminz/users/1' }

    before do
      allow(User).to receive(:find).and_return(user)
    end

    context 'when success' do
      before do
        allow(UserService).to receive(:delete)
      end

      it 'redirect to the index user page' do
        expect(Rails.logger).to_not receive(:error)

        delete path

        expect(response).to redirect_to(admin_users_path)
      end
    end

    context 'when error' do
      before do
        allow(UserService).to receive(:delete).and_raise(StandardError)
      end

      it 'redirect to admin index users page' do
        expect(Rails.logger).to receive(:error)

        delete path

        expect(response).to redirect_to(admin_users_path)
      end
    end
  end
end
