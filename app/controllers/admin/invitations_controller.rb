class Admin::InvitationsController < ActionController::Base
  respond_to? :html
  before_action :load_resource, only: [:edit, :update, :destroy]
  before_action :load_eligible_guests, only: [:edit, :new]

  layout 'admin'

  def index
    @invitations = Invitation.all
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def new
    @invitation = Invitation.new
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def create
    # TO-DO: implement this!
    # InvitationService.create(create_attributes)

    redirect_to admin_invitations_path, notice: 'Invitation created successfully'
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def edit
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def update
    # TO-DO: implement this!
    # InvitationService.update(updated_attributes)

    redirect_to admin_invitations_path, notice: 'Invitation updated successfully'
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  def destroy
    # TO-DO: implement this!
    # InvitationService.delete(@guest)

    redirect_to admin_invitations_path, notice: 'Invitation deleted successfully'
  rescue StandardError => e
    render json: { message: e, status: 500 }
  end

  private

  def load_resource
    @invitation = Invitation.find(params[:id])
  end

  def load_eligible_guests
    selected_guests = @invitation.guests
    uninvited_guests = Guest.left_outer_joins(:invitation_guests).where(invitation_guests: { guest_id: nil })

    @guests = selected_guests + uninvited_guests
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
