require 'date'
require 'icalendar'

require_relative 'api_client'
require_relative 'session'

module Abstractions
  # Represents the overall session schedule of Abstractions.io. Contains the
  # conference session data as well as methods to transform that data to useful
  # formats (ex. `Abstractions::Schedule.new.to_ical`)
  class Schedule
    DATES = {
      'Thursday' => Date.new(2016, 8, 18),
      'Friday'   => Date.new(2016, 8, 19),
      'Saturday' => Date.new(2016, 8, 20)
    }.freeze

    CONFERENCE_TIMEZONE = 'America/New_York'.freeze

    def initialize
      @client = APIClient.new
    end

    def sessions
      @sessions ||= extract_sessions_from_api_response
    end

    def to_ical
      return ical if ical

      cal = Icalendar::Calendar.new
      add_sessions_to cal
      @ical = cal.to_ical
    end

    private

    attr_reader :conn, :response, :client, :ical

    def add_sessions_to(cal)
      sessions.each { |session| session.add_to cal }
    end

    # Requires knowledge of the API structure
    def extract_sessions_from_api_response
      response_body = client.response_body

      # Transform API response into something more genarically useful
      # Note: the data schema has it arranged by days, then stages, then events.
      response_body['days'].each.with_object([]) do |day, sessions|
        day['stages'].each do |stage|
          stage['sessions'].each do |session|
            sessions << new_session(day: day, stage: stage, session: session)
          end
        end
      end
    end

    # Requires knowledge of the API structure
    def new_session(day:, stage:, session:)
      date         = date_from_weekday day['name']
      stage_name   = stage['name']
      session_hash = session.merge changeset(session,
                                             date: date,
                                             stage: stage_name)

      Session.from_hash(session_hash)
    end

    def date_from_weekday(weekday)
      DATES.fetch(weekday)
    end

    # Requires knowledge of the API structure
    def changeset(session, date:, stage:)
      {
        'time_start' => time_from_date_and_string(date, session['time_start']),
        'time_end'   => time_from_date_and_string(date, session['time_end']),
        'stage'      => stage
      }
    end

    def time_from_date_and_string(date, time_str, timezone: CONFERENCE_TIMEZONE)
      time = parse_time(time_str, timezone)
      DateTime.new(
        date.year, date.month, date.day,
        time.hour, time.min, 0,
        time.zone
      )
    end

    # Takes a string or int in military time (ex. "0800" or 1030)
    def parse_time(time, timezone)
      time_str = time.to_s
      hr_str   = time_str[0..1]
      min_str  = time_str[2..3]

      formatted_time_str = "#{hr_str}:#{min_str} #{timezone}"
      Time.parse formatted_time_str
    end
  end
end
