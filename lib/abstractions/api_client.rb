require 'faraday'
require 'json'

module Abstractions
  # A wrapper around the client for the Abstractions.io API
  class APIClient
    DEFAULT_API_BASE = 'http://abstractions.io/api/'.freeze
    DEFAULT_ENDPOINT = 'schedule.json'.freeze

    def initialize(url: DEFAULT_API_BASE)
      @conn     = initialize_connection(url)
      @response = {}
    end

    def response_body(endpoint: DEFAULT_ENDPOINT)
      return response[endpoint] if response[endpoint]

      raw_response       = conn.get(endpoint)
      response[endpoint] = JSON.parse raw_response.body
    end

    private

    attr_reader :conn, :response

    def initialize_connection(url)
      # Logs request details to STDOUT
      Faraday.new(url: url) do |faraday|
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
