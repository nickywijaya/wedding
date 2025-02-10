# frozen_string_literal: true

module GuestService
  class Delete < Services::Base
    attr_accessor :guest

    before_perform :validate

    # Guest => Any
    def initialize(guest)
      @guest = guest
    end

    def perform
      guest.destroy!
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise GuestService::MissingAttributes.new(:guest) if guest.nil?

      raise GuestService::InvalidServiceParameter.new(:guest) unless guest.is_a? Guest
    end
  end
end
