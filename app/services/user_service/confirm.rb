# frozen_string_literal: true

module UserService
  class Confirm < Services::Base
    attr_accessor :user

    before_perform :validate

    # User => Any
    def initialize(user)
      @user = user
    end

    def perform
      user.confirmed_at = Time.now
      user.save!
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise UserService::MissingAttributes.new(:user) if user.nil?

      raise UserService::InvalidServiceParameter.new(:user) unless user.is_a? User
    end
  end
end
