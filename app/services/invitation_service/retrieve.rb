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
      if params[:search].present?
        Guest.where('name LIKE ?', "%#{params[:search].to_s}%")
      else
        Guest.all
      end
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise GuestService::MissingAttributes.new(:params) if params.nil?

      raise GuestService::InvalidServiceParameter.new(:params_search) unless params[:search].is_a? String
    end
  end
end
