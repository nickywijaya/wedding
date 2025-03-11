# frozen_string_literla: true

module BookService
  class BookError < StandardError; end
  class InvalidParameter < BookError; end

  class InvalidServiceParameter < InvalidParameter
    def initialize(field = nil)
      super(I18n.t('services.errors.params_invalid', field: field))
    end
  end

  class MissingAttributes < InvalidParameter
    def initialize(attribute = nil)
      super(I18n.t('services.book_services.missing_attributes', attribute: attribute))
    end
  end

  module_function
  def book(*args) BookService::Book.new(*args).call; end
end
