# frozen_string_literal: true

module WeddingService
  class Update < Services::Base
    attr_accessor :wedding, :params

    before_perform :validate

    # Wedding, Hash => Any
    def initialize(wedding, params)
      @wedding = wedding
      @params = params
    end

    def perform
      wedding.update(params)
      wedding.save!
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise VenueService::MissingAttributes.new(:wedding) if wedding.nil?
      raise VenueService::MissingAttributes.new(:params) if params.nil?

      raise VenueService::InvalidServiceParameter.new(:wedding) unless wedding.is_a? Weddings
      raise VenueService::InvalidServiceParameter.new(:params) unless params.is_a? Hash
    end
  end
end
