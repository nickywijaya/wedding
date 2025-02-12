# frozen_string_literla: true

module GuestService
  class GuestError < StandardError; end
  class InvalidParameter < GuestError; end

  class InvalidServiceParameter < InvalidParameter
    def initialize(field = nil)
      super(I18n.t('services.errors.params_invalid', field: field))
    end
  end

  class MissingAttributes < InvalidParameter
    def initialize(attribute = nil)
      super(I18n.t('services.guest_services.missing_attributes', attribute: attribute))
    end
  end

  module_function
  def create(*args) GuestService::Create.new(*args).call; end
  def retrieve(*args) GuestService::Retrieve.new(*args).call; end
  def update(*args) GuestService::Update.new(*args).call; end
  def delete(*args) GuestService::Delete.new(*args).call; end
end
