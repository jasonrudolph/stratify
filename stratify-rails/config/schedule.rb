set :output, "#{path}/log/cron.log"

every 2.hours do
  rake "collectors:run"
end
