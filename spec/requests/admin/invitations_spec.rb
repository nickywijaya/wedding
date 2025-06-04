require 'rails_helper'

RSpec.describe 'Admin::InvitationsController', type: :request do
  include Devise::Test::IntegrationHelpers

  let(:user)       { create(:user, :confirmed) }
  let(:invitation) { build_stubbed(:invitation) }
  let(:guest)      { build_stubbed(:guest) }

  before do
    sign_in user
    allow_any_instance_of(Admin::InvitationsController).to receive(:render)
  end

  describe 'GET /_adminz/invitations' do
    let(:path)  { '/_adminz/invitations' }

    context 'when success' do
      before do
        allow(InvitationService).to receive(:retrieve).and_return([invitation])
      end

      it 'renders the index template' do
        get path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when error' do
      before do
        allow(InvitationService).to receive(:retrieve).and_raise(StandardError)
      end

      it 'redirect to admin error page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(admin_error_url)
      end
    end

  end

  describe 'GET /_adminz/invitations/new' do
    let(:path)  { '/_adminz/invitations/new' }

    before do
      allow(Guest).to receive_message_chain(:left_outer_joins, :where).and_return([guest])
    end

    context 'when success' do
      it 'renders the new template' do
        get path
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when error' do
      before do
        allow(Invitation).to receive(:new).and_raise(StandardError)
      end

      it 'redirect to admin new invitation page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(admin_invitations_path)
      end
    end

  end

  describe 'POST /_adminz/invitations' do
    let(:path)  { '/_adminz/invitations' }
    let(:params) do
      {
        invitation: {
          wedding_id: 12313,
          participant: 10,
          attendance_type: Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony],
          with_family: true,
          with_partner: true,
          guest_ids: [1,2,3]
        }
      }
    end

    context 'when success' do
      before do
        allow(InvitationService).to receive(:create)
      end

      it 'success and redirect to index page' do
        post path, params: params

        expect(response).to redirect_to(admin_invitations_path)
      end
    end

    context 'when raise InvitationService::InvitationError' do
      before do
        allow(InvitationService).to receive(:create).and_raise(InvitationService::InvitationError)
      end

      it 'redirect to new admin invitation page' do
        expect(Rails.logger).to receive(:error)

        post path, params: params

        expect(response).to redirect_to(new_admin_invitation_path)
      end
    end

    context 'when raise StandardError' do
      before do
        allow(InvitationService).to receive(:create).and_raise(StandardError)
      end

      it 'redirect to new admin invitation page' do
        expect(Rails.logger).to receive(:error)

        post path, params: params

        expect(response).to redirect_to(new_admin_invitation_path)
      end
    end

  end

  describe 'GET /_adminz/invitations/1/edit' do
    let(:path)  { '/_adminz/invitations/1/edit' }

    before do
      allow(Invitation).to receive(:find).and_return(invitation)
      allow(Guest).to receive_message_chain(:left_outer_joins, :where).and_return([guest])
    end

    context 'when success' do
      before do
        allow(invitation).to receive(:guests).and_return([guest])
      end

      it 'renders the edit template' do
        get path

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when error' do
      before do
        allow(invitation).to receive(:guests).and_raise(StandardError)
      end

      it 'redirect to admin index invitations page' do
        expect(Rails.logger).to receive(:error)

        get path

        expect(response).to redirect_to(admin_invitations_path)
      end
    end

  end

  describe 'PUT /_adminz/invitations/1' do
    let(:path)  { '/_adminz/invitations/1' }
    let(:params) do
      {
        invitation: {
          wedding_id: 12313,
          comments: 'test-comment',
          participant: 10,
          attendance_type: Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony],
          with_family: true,
          with_partner: true,
          sent: true,
          guest_ids: [1,2,3]
        }
      }
    end

    before do
      allow(Invitation).to receive(:find).and_return(invitation)
    end

    context 'when success' do
      before do
        allow(InvitationService).to receive(:update)
      end

      it 'success and redirect to index page' do
        put path, params: params

        expect(response).to redirect_to(admin_invitations_path)
      end
    end

    context 'when raise InvitationService::InvitationError' do
      before do
        allow(InvitationService).to receive(:update).and_raise(InvitationService::InvitationError)
      end

      it 'redirect to edit admin invitation page' do
        expect(Rails.logger).to receive(:error)

        put path, params: params

        expect(response).to redirect_to(edit_admin_invitation_path)
      end
    end

    context 'when raise StandardError' do
      before do
        allow(InvitationService).to receive(:update).and_raise(StandardError)
      end

      it 'redirect to edit admin invitation page' do
        expect(Rails.logger).to receive(:error)

        put path, params: params

        expect(response).to redirect_to(edit_admin_invitation_path)
      end
    end
  end

  describe 'DELETE /_adminz/invitations/1' do
    let(:path)  { '/_adminz/invitations/1' }

    before do
      allow(Invitation).to receive(:find).and_return(invitation)
    end

    context 'when success' do
      before do
        allow(InvitationService).to receive(:delete)
      end

      it 'success and redirect to index page' do
        delete path

        expect(response).to redirect_to(admin_invitations_path)
      end
    end

    context 'when raise StandardError' do
      before do
        allow(InvitationService).to receive(:delete).and_raise(StandardError)
      end

      it 'redirect to index admin invitations page' do
        expect(Rails.logger).to receive(:error)

        delete path

        expect(response).to redirect_to(admin_invitations_path)
      end
    end

  end
end
