class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :check_json

  def check_json
    return if request.format == 'json'
    render json: ErrorSerializer.request_not_acceptable, status: :not_acceptable
  end

  def respond_with_errors(object)
    render json: ErrorSerializer.serialize(object), status: :unprocessable_entity
  end

  def respond_with_no_found(message)
    render json: ErrorSerializer.request_not_found(message), status: :not_found
  end

  def respond_with_bad_request(message)
    render json: ErrorSerializer.request_bad(message), status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    respond_with_no_found(e.message)
  end

  rescue_from ActionController::ParameterMissing do |e|
    respond_with_bad_request(e.message)
  end

end
