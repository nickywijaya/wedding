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

      raise VenueService::InvalidServiceParameter.new(:venue) unless venue.is_a? Venue
      raise VenueService::InvalidServiceParameter.new(:params) unless params.is_a? Hash

      raise VenueService::InvalidServiceParameterWithMessage.new(:name, 'tidak boleh kosong') if params[:name].blank?
      raise VenueService::InvalidServiceParameterWithMessage.new(:address, 'tidak boleh kosong') if params[:address].blank?
      raise VenueService::InvalidServiceParameterWithMessage.new(:map_src, 'tidak boleh kosong') if params[:map_src].blank?
      raise VenueService::InvalidServiceParameterWithMessage.new(:max_attendees, 'harus lebih dari 0') if params[:max_attendees].zero?
      raise VenueService::InvalidServiceParameterWithMessage.new(:venue_type, 'tidak boleh kosong') if params[:venue_type].blank?
    end
  end
end
