namespace :collectors do
  desc "Run all configured collectors"
  task :run => [:environment] do
    CollectorCoordinator.run_all
  end
end
