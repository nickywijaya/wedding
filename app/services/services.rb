# frozen_string_literal: true

module Services
  class Errors < StandardError; end
  class InvalidContext < Errors; end

  class ParameterMissing < Errors
    def initialize(attribute = nil)
      super(I18n.t('services.missing_attributes', attribute: attribute))
    end
  end

  class ParameterInvalid < Errors
    def initialize(field = nil)
      super(I18n.t('services.errors.params_invalid', field: field))
    end
  end

  class Base
    extend ActiveModel::Callbacks

    define_model_callbacks :perform

    def call
      run_callbacks :perform do
        perform
      end
    end

    def perform
      raise NotImplementedError
    end
  end
end
