class ApplicationController < ActionController::API
  around_action :handle_exceptions, if: proc { request.path.include?('/api') }

  def json_response(options = {}, status = 200)
    render json: JsonResponse.new(options), status: status
  end

  # Catch exception and return JSON-formatted error
  def handle_exceptions
    begin
      yield
    rescue ActiveRecord::RecordNotFound => e
      @status = 404
      @message = 'Record not found'
    rescue ActiveRecord::RecordInvalid => e
      json_response({ success: false, message: 'Validation failed', errors: e.record.errors.messages }, 500) && return
    rescue ArgumentError => e
      @status = 400
    rescue StandardError => e
      binding.break
      @status = 500
    end
    json_response({ success: false, message: @message || e.class.to_s, errors: [{ detail: e.message }] }, @status) unless e.class == NilClass
  end

  def array_serializer
    ActiveModelSerializers::SerializableResource
  end
end
