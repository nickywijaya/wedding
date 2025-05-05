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
      if params[:search].present? || params[:guest_source].present?
        data = Invitation.joins(:invitation_guests)
               .joins("INNER JOIN guests ON guests.id = invitation_guests.guest_id")

        data = data.where("guests.name ILIKE ?", "%#{params[:search]}%") if params[:search].present?

        if params[:guest_source].present?
          from_groom = (params[:guest_source] == 'groom')
          data = data.where("guests.from_groom = ?", from_groom)
        end

        return data.uniq
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
