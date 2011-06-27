job_type :rake, "cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

set :output, "#{path}/log/cron.log"

every 2.hours do
  rake "collectors:run"
end
