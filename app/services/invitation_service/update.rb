# frozen_string_literal: true

module InvitationService
  class Update < Services::Base
    attr_accessor :invitation, :params

    before_perform :validate

    # Invitation, Hash => Any
    def initialize(invitation, params)
      @invitation = invitation
      @params = params
    end

    def perform
      ActiveRecord::Base.transaction do
        # check the updated guest data
        old_guest_ids = invitation.guests.pluck(:id)

        if old_guest_ids.sort != params[:guest_ids].sort
          # delete the old one
          invitation.invitation_guests.each do |invitation_guest|
            invitation_guest.destroy!
          end

          params[:guest_ids].each do |guest_id|
            invitation_guest = InvitationGuest.new
            invitation_guest.invitation_id = invitation.id
            invitation_guest.guest_id = guest_id
            invitation_guest.save!
          end
        end

        # update invitation
        invitation.wedding_id = params[:wedding_id]
        invitation.comments = params[:comments]
        invitation.save!
      end
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise InvitationService::MissingAttributes.new(:invitation) if invitation.nil?
      raise InvitationService::MissingAttributes.new(:params) if params.nil?

      raise InvitationService::InvalidServiceParameter.new(:invitation) unless invitation.is_a? Invitation
      raise InvitationService::InvalidServiceParameter.new(:params) unless params.is_a? Hash

      raise InvitationService::WeddingNotFound.new if params[:wedding_id].to_i.zero?
      raise InvitationService::EmptyGuest.new if params[:guest_ids].blank?
    end
  end
end
