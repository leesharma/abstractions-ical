require 'faraday'
require 'api_cache'
require 'moneta'
require 'dalli'
require 'json'

module Abstractions
  # A wrapper around the client for the Abstractions.io API
  class APIClient
    DEFAULT_API_BASE = 'http://abstractions.io/api/'.freeze
    DEFAULT_ENDPOINT = 'schedule.json'.freeze

    def initialize(url: DEFAULT_API_BASE)
      @conn = initialize_connection(url)
    end

    def response_body(endpoint: DEFAULT_ENDPOINT)
      APICache.get('abstractions_schedule', cache: 600) do
        response = conn.get(endpoint)

        if response.success?
          JSON.parse response.body
        else
          raise APICache::InvalidResponse
        end
      end
    end

    private

    attr_reader :conn, :response

    def initialize_connection(url)
      memcached_opts = {
        server:   (ENV['MEMCACHIER_SERVERS'] || '127.0.0.1:11211').split(','),
        username: ENV['MEMCACHIER_USERNAME'],
        password: ENV['MEMCACHIER_PASSWORD'],
        failover: true,
        socket_timeout: 1.5,
        socket_failure_delay: 0.2
      }
      APICache.store = Moneta.new(:MemcachedDalli, memcached_opts)

      # Logs request details to STDOUT
      Faraday.new(url: url) do |faraday|
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
