class ApplicationController < ActionController::API
    before_action :authenticate_request
  
    attr_reader :current_user
  
    private
  
    def authenticate_request
      header = request.headers["Authorization"]
      token = header&.split(" ")&.last
      decoded = JsonWebToken.decode(token)
  
      @current_user = User.find(decoded[:user_id]) if decoded
    rescue
      render json: { errors: "Unauthorized" }, status: :unauthorized
    end
  end
  