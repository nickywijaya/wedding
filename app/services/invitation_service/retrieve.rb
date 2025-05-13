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
      if params[:search].present? || params[:guest_source].present? || params[:attendance_type] >= 0
        data = Invitation.joins(:invitation_guests)
               .joins("INNER JOIN guests ON guests.id = invitation_guests.guest_id")

        data = data.where("guests.name ILIKE ?", "%#{params[:search]}%") if params[:search].present?

        if params[:guest_source].present?
          from_groom = (params[:guest_source] == 'groom')
          data = data.where("guests.from_groom = ?", from_groom)
        end

        if params[:attendance_type] >= 0
          attendance_types = []

          case params[:attendance_type]
          when Invitation::ATTENDANCE_TYPE_ENUM[:holy_matrimony] # 0
            attendance_types = [0, 2]
          when Invitation::ATTENDANCE_TYPE_ENUM[:reception] # 1
            attendance_types = [1, 2]
          when Invitation::ATTENDANCE_TYPE_ENUM[:both] # 2
            attendance_types = [2]
          end

          data = data.where("attendance_type IN (?)", attendance_types)
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
