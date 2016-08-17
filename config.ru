require './web/app'

$stdout.sync = true  # show puts output on heroku logs
run Sinatra::Application
