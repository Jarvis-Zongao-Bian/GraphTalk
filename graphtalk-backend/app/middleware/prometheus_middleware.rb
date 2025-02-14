require 'prometheus/client'
require 'prometheus/client/formats/text'
require 'prometheus/client/rack/exporter'

class PrometheusMiddleware
  def initialize(app)
    @app = app
    @request_count = Prometheus::Client.registry.counter(
      :http_requests_total,
      docstring: 'Total number of HTTP requests',
      labels: %i[method path status]
    )
  end

  def call(env)
    status, headers, response = @app.call(env)
    @request_count.increment(labels: { method: env['REQUEST_METHOD'], path: env['PATH_INFO'], status: status })
    [status, headers, response]
  end
end
