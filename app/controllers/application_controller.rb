class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: ErrorSerializer.new, status: :not_found
  end

end
