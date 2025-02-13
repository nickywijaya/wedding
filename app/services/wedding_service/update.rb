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
      raise WeddingService::MissingAttributes.new(:wedding) if wedding.nil?
      raise WeddingService::MissingAttributes.new(:params) if params.nil?

      raise WeddingService::InvalidServiceParameter.new(:wedding) unless wedding.is_a? Weddings
      raise WeddingService::InvalidServiceParameter.new(:params) unless params.is_a? Hash

      raise WeddingService::InvalidServiceParameterWithMessage.new(:hashtag, 'tidak boleh kosong') if params[:hashtag].blank?
      raise WeddingService::InvalidServiceParameterWithMessage.new(:story, 'tidak boleh kosong') if params[:story].blank?
    end
  end
end
