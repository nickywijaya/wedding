# frozen_string_literal: true

module GuestService
  class Create < Services::Base
    attr_accessor :params

    before_perform :validate

    # Hash => Any
    def initialize(params)
      @params = params
    end

    def perform
      guest = Guest.new(params)
      guest.save!
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise GuestService::MissingAttributes.new(:guest) if params.nil?

      raise GuestService::InvalidServiceParameter.new(:params) unless params.is_a? Hash

      raise GuestService::InvalidServiceParameter.new(:name) if params[:name].nil?
      raise GuestService::InvalidServiceParameter.new(:gender) if params[:gender].nil?
      raise GuestService::InvalidServiceParameter.new(:contact) if params[:contact].nil?
      raise GuestService::InvalidServiceParameter.new(:contact_source) if params[:contact_source].nil?
      raise GuestService::InvalidServiceParameter.new(:guest_relation) if params[:from_groom].nil?
    end
  end
end
