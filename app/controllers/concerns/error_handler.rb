module Concerns
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError, with: :render_internal_server_error
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
      rescue_from ActiveRecord::RecordInvalid, ActiveModel::ValidationError,
                  ActiveRecord::RecordNotUnique,
                  ActiveModel::Serializer::Null,
                  with: :render_invalid_record
    end

    def render_error(message, status)
      status_code = Rack::Utils::SYMBOL_TO_STATUS_CODE[status]
      render json: { error: { status: status_code, message: message } },
             status: status
    end

    def render_not_found(error)
      render_error(error.message, :not_found)
    end

    def render_invalid_record(error)
      render_error(error.message, :unprocessable_entity)
    end

    def render_internal_server_error(error)
      render_error(error.message, :internal_server_error)
    end
  end
end
