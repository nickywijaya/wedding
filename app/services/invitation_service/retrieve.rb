# frozen_string_literal: true

module InvitationService
  class Retrieve < Services::Base
    attr_accessor :params

    before_perform :validate

    # String => Any
    def initialize(params)
      @params = params
    end

    def perform
      if params[:search].present?
        Invitation.joins(:invitation_guests)
                  .joins("INNER JOIN guests ON guests.id = invitation_guests.guest_id")
                  .where("guests.name LIKE ?", "%#{params[:search]}%")
      else
        Invitation.all
      end
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise InvitationService::MissingAttributes.new(:params) if params.nil?

      raise InvitationService::InvalidServiceParameter.new(:name) unless params[:search].is_a? String
    end
  end
end
