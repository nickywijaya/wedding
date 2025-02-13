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

      raise GuestService::InvalidServiceParameterWithMessage.new(:name, 'tidak boleh kosong') if params[:name].blank?
      raise GuestService::InvalidServiceParameterWithMessage.new(:gender, 'harus dipilih') if params[:gender].nil?
      raise GuestService::InvalidServiceParameterWithMessage.new(:contact, 'tidak boleh kosong') if params[:contact].blank?
      raise GuestService::InvalidServiceParameterWithMessage.new(:contact_source, 'harus dipilih') if params[:contact_source].blank?
      raise GuestService::InvalidServiceParameterWithMessage.new(:guest_relation, 'harus dipilih') if params[:from_groom].nil?
    end

    def transform_params
      params["gender"] = params["gender"].to_i
      params["contact_source"] = params["contact_source"].to_i
      params["from_groom"] = (params["from_groom"] == "true") ? true : false
    end
  end
end
