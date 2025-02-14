class Rack::Attack
  # Allow unlimited requests for admins
  safelist("allow_admin") do |req|
    token = req.env["HTTP_AUTHORIZATION"]&.split(" ")&.last
    decoded = JsonWebToken.decode(token)
    decoded && User.find_by(id: decoded[:user_id])&.admin?
  end

  # Limit normal users to 100 requests per 15 minutes
  throttle("api/ip", limit: 100, period: 15.minutes) do |req|
    req.ip unless req.path.start_with?("/assets")
  end
end
