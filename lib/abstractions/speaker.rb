module Abstractions
  # Represents a speaker at the conference, including basic biographical info
  class Speaker
    IMAGE_BASE = 'http://abstractions.io/images/speakers/'.freeze

    attr_reader :name, :tagline, :bio, :twitter

    def initialize(speaker_params)
      @name    = speaker_params['name']
      @tagline = speaker_params.fetch('bio', {}).fetch('short', nil)
      @bio     = speaker_params.fetch('bio', {}).fetch('long', nil)
      @twitter = speaker_params['twitter']
    end

    private

    def image_url_from(filename, base: IMAGE_BASE)
      return '' unless filename
      "#{base}#{filename}"
    end
  end
end
