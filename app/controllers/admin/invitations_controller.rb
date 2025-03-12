class Admin::InvitationsController < AdminController
  before_action :load_resource, only: [:edit, :update, :destroy]
  before_action :load_uninvited_guests, only: [:edit, :new]

  respond_to? :html
  layout 'admin'

  def index
    @invitations = InvitationService.retrieve(index_attributes)
  rescue StandardError => e
    session[:error_message] = e.message
    session[:error_backtrace] = e.backtrace.take(3)
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_error_url
  end

  def new
    @invitation = Invitation.new
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to admin_invitations_path
  end

  def create
    InvitationService.create(create_attributes)

    redirect_to admin_invitations_path, notice: 'Sukses menambah undangan'
  rescue InvitationService::InvitationError => e
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

    redirect_to admin_invitations_path, notice: 'Sukses mengubah data undangan'
  rescue InvitationService::InvitationError => e
    flash[:warning] = e.message
    redirect_to edit_admin_invitation_path
  rescue StandardError => e
    flash[:error] = "Tetap tenang tetap semangat"
    redirect_to edit_admin_invitation_path
  end

  def destroy
    InvitationService.delete(@invitation)

    redirect_to admin_invitations_path, notice: 'Sukses menghapus undangan'
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
    attribute = params.permit(:search, :commit).to_h

    # transform attributes
    attribute["search"] = attribute["search"].to_s.strip

    attribute
  end

  def create_attributes
    attribute = params.required(:invitation)
          .permit(:wedding_id,
                  :participant,
                  :attendance_type,
                  :with_family,
                  :with_partner,
                  guest_ids: []
                ).to_h

    # transform attributes
    attribute[:wedding_id] = attribute[:wedding_id].to_i
    attribute[:guest_ids] = attribute[:guest_ids].map(&:to_i).reject { |x| x.zero? }
    attribute[:attendance_type] = attribute[:attendance_type].to_i
    attribute[:with_family] = (attribute[:with_family].to_s == "true") ? true : false
    attribute[:with_partner] = (attribute[:with_partner].to_s == "true") ? true : false
    attribute[:participant] = attribute[:guest_ids].count if attribute[:participant].to_i.zero?

    attribute
  end

  def update_attributes
    attribute = params.required(:invitation)
          .permit(:wedding_id,
                  :comments,
                  :participant,
                  :attendance_type,
                  :with_family,
                  :with_partner,
                  guest_ids: []
                ).to_h

    # transform attributes
    attribute[:wedding_id] = attribute[:wedding_id].to_i
    attribute[:comments] = attribute[:comments].to_s
    attribute[:guest_ids] = attribute[:guest_ids].map(&:to_i).reject { |x| x.zero? }
    attribute[:attendance_type] = attribute[:attendance_type].to_i
    attribute[:with_family] = (attribute[:with_family].to_s == "true") ? true : false
    attribute[:with_partner] = (attribute[:with_partner].to_s == "true") ? true : false
    attribute[:participant] = attribute[:guest_ids].count if attribute[:participant].to_i.zero?

    attribute
  end
end
