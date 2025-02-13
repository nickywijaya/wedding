# frozen_string_literla: true

module UserService
  class UserError < StandardError; end
  class InvalidParameter < UserError; end

  class InvalidServiceParameter < InvalidParameter
    def initialize(field = nil)
      super(I18n.t('services.errors.params_invalid', field: field))
    end
  end

  class InvalidServiceParameterWithMessage < InvalidParameter
    def initialize(field = nil, message = nil)
      message = "tidak valid" if message.nil?

      super(I18n.t('services.errors.params_invalid_with_message', field: field, message: message))
    end
  end

  class MissingAttributes < InvalidParameter
    def initialize(attribute = nil)
      super(I18n.t('services.user_services.missing_attributes', attribute: attribute))
    end
  end

  module_function
  def confirm(*args) UserService::Confirm.new(*args).call; end
  def retrieve(*args) UserService::Retrieve.new(*args).call; end
  def revoke(*args) UserService::Revoke.new(*args).call; end
  def delete(*args) UserService::Delete.new(*args).call; end
end
