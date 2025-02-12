class Admin::InvitationsController < ActionController::Base
  respond_to? :html
  before_action :load_resource, only: [:edit, :update, :destroy]
  before_action :load_uninvited_guests, only: [:edit, :new]

  layout 'admin'

  def index
    @invitations = InvitationService.retrieve(index_attributes)
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_invitations_path
  end

  def new
    @invitation = Invitation.new
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_invitations_path
  end

  def create
    InvitationService.create(create_attributes)

    redirect_to admin_invitations_path, notice: 'Invitation created successfully'
  rescue InvitationService::InvalidServiceParameter, InvitationService::InvitationError => e
    flash[:warning] = e.message
    redirect_to new_admin_invitation_path
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to new_admin_invitation_path
  end

  def edit
    selected_guests = @invitation.guests

    @guests = selected_guests + @guests
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_invitations_path
  end

  def update
    InvitationService.update(@invitation, update_attributes)

    redirect_to admin_invitations_path, notice: 'Invitation updated successfully'
  rescue InvitationService::InvalidServiceParameter => e
    flash[:warning] = e.message
    redirect_to edit_admin_invitation_path
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to edit_admin_invitation_path
  end

  def destroy
    InvitationService.delete(@invitation)

    redirect_to admin_invitations_path, notice: 'Invitation deleted successfully'
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_invitations_path
  end

  private

  def load_resource
    @invitation = Invitation.find(params[:id])
  end

  def load_uninvited_guests
    uninvited_guests = Guest.left_outer_joins(:invitation_guests).where(invitation_guests: { guest_id: nil })

    @guests = uninvited_guests
  end

  def index_attributes
    attribute = params.permit(:search).to_h

    # trasnform attributes
    attribute["search"] = attribute["search"].to_s.strip

    attribute
  end

  def create_attributes
    attribute = params.required(:invitation)
          .permit(:wedding_id,
                  guest_ids: []
                ).to_h

    # trasnform attributes
    attribute[:wedding_id] = attribute[:wedding_id].to_i
    attribute[:guest_ids] = attribute[:guest_ids].map(&:to_i).reject { |x| x.zero? }

    attribute
  end

  def update_attributes
    attribute = params.required(:invitation)
          .permit(:wedding_id,
                  :comments,
                  guest_ids: []
                ).to_h

    # trasnform attributes
    attribute[:wedding_id] = attribute[:wedding_id].to_i
    attribute[:comments] = attribute[:comments].to_s
    attribute[:guest_ids] = attribute[:guest_ids].map(&:to_i).reject { |x| x.zero? }

    attribute
  end
end
