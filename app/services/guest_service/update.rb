# frozen_string_literal: true

module GuestService
  class Update < Services::Base
    attr_accessor :guest, :params

    before_perform :validate

    # Guest, Hash => Any
    def initialize(guest, params)
      @guest = guest
      @params = params
    end

    def perform
      guest.update(params)
      guest.save!
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise GuestService::MissingAttributes.new(:guest) if guest.nil?
      raise GuestService::MissingAttributes.new(:params) if params.nil?

      raise GuestService::InvalidServiceParameter.new(:guest) unless guest.is_a? Guest
      raise GuestService::InvalidServiceParameter.new(:params) unless params.is_a? Hash

      raise GuestService::InvalidServiceParameter.new(:params_name) if params[:name].nil?
      raise GuestService::InvalidServiceParameter.new(:params_name) if params[:gender].nil?
      raise GuestService::InvalidServiceParameter.new(:params_name) if params[:contact].nil?
      raise GuestService::InvalidServiceParameter.new(:params_name) if params[:contact_source].nil?
      raise GuestService::InvalidServiceParameter.new(:params_name) if params[:from_groom].nil?
    end
  end
end
