require 'sinatra'
require 'newrelic_rpm'
require_relative '../lib/abstractions'

schedule = Abstractions::Schedule.new

get '/' do
  content_type 'text/plain'
  "=====================================\n" +
  "Abstractions.io Conference Schedule\n" +
  "=====================================\n" +
  "Need the .ics version of this file?\n" +
  "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}/abstractions.ics\n" +
  "=====================================\n" +
  "\n\n" +
  schedule.to_ical
end

get '/abstractions.ics' do
  content_type 'text/calendar'
  schedule.to_ical
end
