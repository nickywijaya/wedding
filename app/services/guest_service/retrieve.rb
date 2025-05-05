# frozen_string_literal: true

module GuestService
  class Retrieve < Services::Base
    attr_accessor :params

    before_perform :validate

    # String => Any
    def initialize(params)
      @params = params
    end

    def perform
      data = Guest.all

      data = data.where('name ILIKE ?', "%#{params[:search].to_s}%") if params[:search].present?

      if params[:guest_source].present?
        from_groom = (params[:guest_source] == 'groom')
        data = data.where("from_groom = ?", from_groom)
      end

      data
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise GuestService::MissingAttributes.new(:params) if params.nil?

      raise GuestService::InvalidServiceParameter.new(:name) unless params[:search].is_a? String
    end
  end
end
