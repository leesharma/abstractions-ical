require_relative 'speaker'
require_relative 'talk'
require_relative 'stage'

module Abstractions
  # Represents a conference session, including the talk details, speaker,
  # time, location, and URL
  class Session
    URL_BASE = 'http://abstractions.io/schedule/'.freeze

    attr_reader :time_start, :time_end, :stage, :talk, :speaker, :url

    def initialize(params)
      @id = params['id']

      @time_start = params['time_start']
      @time_end   = params['time_end']
      @stage      = Stage.new params['stage']
      @talk       = Talk.new params['talk']
      @speaker    = Speaker.new params['speaker']
      @url        = url_from(id)
    end

    class << self
      alias_method :from_hash, :new
    end

    def description
      talk.description + bio_text + twitter_contact_text
    end

    def title
      "#{talk.title} (#{speaker.name})"
    end

    def location
      stage.name
    end

    private

    attr_reader :id

    def image_url
      speaker.image_url
    end

    def url_from(id)
      URL_BASE + "#session-full-#{id}"
    end

    def bio_text
      speaker.bio ? "\n\nAbout #{speaker.name}:\n\n#{speaker.bio}" : ''
    end

    def twitter_contact_text
      name = speaker.name
      speaker.twitter ? "\n\nFind #{name} on Twitter: @#{speaker.twitter}" : ''
    end
  end
end
