# config/initializers/prometheus_exporter.rb

require 'prometheus_exporter/client'

PrometheusExporter::Client.default = PrometheusExporter::Client.new(
  host: "prometheus_exporter", 
  port: 9394
)