class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def render_service_api(success_status, error_status, service)

    return render json: service.result , status: success_status || :ok if service && service.success?

    render json: {
      error_messages: service.try(:errors).try(:full_messages) || ['Error in render requisition']
    }, status: error_status || :internal_server_error
  end
end
