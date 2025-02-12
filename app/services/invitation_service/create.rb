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
        invitation = Invitation.new(params)
        invitation.save!

        # create invitation guest!
      end
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise InvitationService::MissingAttributes.new(:venue) if params.nil?

      raise InvitationService::InvalidServiceParameter.new(:params) unless params.is_a? Hash

      raise InvitationService::InvalidServiceParameter.new(:params_name) if params[:name].nil?
      raise InvitationService::InvalidServiceParameter.new(:params_name) if params[:gender].nil?
      raise InvitationService::InvalidServiceParameter.new(:params_name) if params[:contact].nil?
      raise InvitationService::InvalidServiceParameter.new(:params_name) if params[:contact_source].nil?
      raise InvitationService::InvalidServiceParameter.new(:params_name) if params[:from_groom].nil?
    end
  end
end
