# frozen_string_literal: true

module InvitationService
  class Update < Services::Base
    attr_accessor :invitation, :params

    before_perform :validate

    # Guest, Hash => Any
    def initialize(invitation, params)
      @invitation = invitation
      @params = params
    end

    def perform
      ActiveRecord::Base.transaction do
        # update invitation guest
        # TO-DO: check the guest!

        # update invitation
        invitation.update(params)
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

      # raise InvitationService::InvalidServiceParameter.new(:params_name) if params[:name].nil?
      # raise InvitationService::InvalidServiceParameter.new(:params_name) if params[:gender].nil?
      # raise InvitationService::InvalidServiceParameter.new(:params_name) if params[:contact].nil?
      # raise InvitationService::InvalidServiceParameter.new(:params_name) if params[:contact_source].nil?
      # raise InvitationService::InvalidServiceParameter.new(:params_name) if params[:from_groom].nil?
    end
  end
end
