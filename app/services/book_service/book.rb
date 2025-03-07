# frozen_string_literal: true

module BookService
  class Book < Services::Base
    attr_accessor :invitation, :params

    before_perform :validate

    # Invitation, Hash => Any
    def initialize(invitation, params)
      @invitation = invitation
      @params = params
    end

    def perform
      invitation.comments = params[:comments]
      invitation.attending = params[:attending]
      invitation.save!
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise BookService::MissingAttributes.new(:params) if params.nil?
      raise BookService::MissingAttributes.new(:invitation) if invitation.nil?

      raise BookService::InvalidServiceParameter.new(:params) unless params.is_a? Hash
      raise BookService::InvalidServiceParameter.new(:invitation) unless invitation.is_a? Invitation
    end
  end
end
