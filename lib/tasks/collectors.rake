namespace :collectors do
  desc "Run all configured collectors"
  task :run => [:environment] do
    Stratify::CollectorCoordinator.run_all
  end
end
