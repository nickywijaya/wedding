# frozen_string_literal: true

module UserService
  class Retrieve < Services::Base
    attr_accessor :params

    before_perform :validate

    # String => Any
    def initialize(params)
      @params = params
    end

    def perform
      if params[:search].present?
        User.where('email LIKE ?', "%#{params[:search].to_s}%")
      else
        User.all
      end
    rescue StandardError => e
      raise e
    end

    private

    def validate
      raise UserService::MissingAttributes.new(:params) if params.nil?

      raise UserService::InvalidServiceParameter.new(:search) unless params[:search].is_a? String
    end
  end
end
