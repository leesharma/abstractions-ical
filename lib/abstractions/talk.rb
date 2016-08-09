module Abstractions
  # Represents a talk given at a conference session
  class Talk
    attr_reader :title, :description

    def initialize(talk_params)
      @title       = talk_params['title']
      @description = talk_params['description']
    end
  end
end
