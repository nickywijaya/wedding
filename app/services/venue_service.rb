# frozen_string_literla: true

module VenueService
  class VenueError < StandardError; end
  class InvalidParameter < VenueError; end

  class InvalidServiceParameter < InvalidParameter
    def initialize(field = nil)
      super(I18n.t('services.errors.params_invalid', field: field))
    end
  end

  class MissingAttributes < InvalidParameter
    def initialize(attribute = nil)
      super(I18n.t('services.venue_services.missing_attributes', attribute: attribute))
    end
  end

  module_function
  def update(*args) VenueService::Update.new(*args).call; end
end
