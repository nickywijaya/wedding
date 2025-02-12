# frozen_string_literla: true

module InvitationService
  class InvitationError < StandardError; end
  class InvalidParameter < InvitationError; end

  class InvalidServiceParameter < InvalidParameter
    def initialize(field = nil)
      super(I18n.t('services.errors.params_invalid', field: field))
    end
  end

  class MissingAttributes < InvalidParameter
    def initialize(attribute = nil)
      super(I18n.t('services.invitation_services.missing_attributes', attribute: attribute))
    end
  end

  module_function
  def create(*args) InvitationService::Create.new(*args).call; end
  def retrieve(*args) InvitationService::Retrieve.new(*args).call; end
  def update(*args) InvitationService::Update.new(*args).call; end
  def delete(*args) InvitationService::Delete.new(*args).call; end
end
