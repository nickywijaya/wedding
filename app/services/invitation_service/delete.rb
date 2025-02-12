# frozen_string_literal: true

module InvitationService
  class Delete < Services::Base
    attr_accessor :invitation

    before_perform :validate

    # Guest => Any
    def initialize(invitation)
      @invitation = invitation
    end

    def perform
      ActiveRecord::Base.transaction do
        # delete invitation guest

        # delete invitation
        invitation.destroy!
      end
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise InvitationService::MissingAttributes.new(:guest) if invitation.nil?

      raise InvitationService::InvalidServiceParameter.new(:guest) unless invitation.is_a? Invitation
    end
  end
end
