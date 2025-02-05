# frozen_string_literal: true

module VenueService
  class Update < Services::Base
    attr_accessor :venue, :params

    before_perform :validate

    # Venue, Hash => Any
    def initialize(venue, params)
      @venue = venue
      @params = params
    end

    def perform
      venue.update(params)
      venue.save!
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise VenueService::MissingAttributes.new(:venue) if venue.nil?
      raise VenueService::MissingAttributes.new(:params) if params.nil?

      raise VenueService::InvalidServiceParameter.new(:params) unless venue.is_a? Venue
      raise VenueService::InvalidServiceParameter.new(:params) unless params.is_a? Hash
    end
  end
end