# frozen_string_literal: true

module InvitationService
  class Create < Services::Base
    attr_accessor :params

    before_perform :validate

    # Hash => Any
    def initialize(params)
      @params = params
    end

    def perform
      ActiveRecord::Base.transaction do
        # create invitation
        invitation = Invitation.new
        invitation.id = SecureRandom.uuid
        invitation.wedding_id = params[:wedding_id]
        invitation.participant = params[:participant]
        invitation.attendance_type = params[:attendance_type]
        invitation.with_family = params[:with_family]
        invitation.with_partner = params[:with_partner]
        invitation.sent = false # default is false since the invitation is not yet sent to the target
        invitation.save!

        # create invitation guest
        params[:guest_ids].each do |guest_id|
          invitation_guest = InvitationGuest.new
          invitation_guest.invitation_id = invitation.id
          invitation_guest.guest_id = guest_id
          invitation_guest.save!
        end
      end
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise InvitationService::MissingAttributes.new(:params) if params.nil?

      raise InvitationService::InvalidServiceParameter.new(:params) unless params.is_a? Hash

      raise InvitationService::WeddingNotFound.new if params[:wedding_id].to_i.zero?
      raise InvitationService::EmptyGuest.new if params[:guest_ids].blank?
    end
  end
end
