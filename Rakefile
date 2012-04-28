stratify_gems = [
  'stratify-base',
  'stratify-foursquare',
  'stratify-garmin',
  'stratify-gowalla',
  'stratify-instapaper',
  'stratify-itunes',
  'stratify-rhapsody',
  'stratify-twitter',
]

stratify_components = stratify_gems + ['stratify-rails']

ROOT = File.dirname(__FILE__)

def gem_command(command, *args)
  ruby "-S gem #{command} #{args.join(' ')}"
end

def rake_command(command)
  ruby "-S bundle exec rake #{command}"
end

namespace :components do
  desc 'Runs the given shell command in each component directory (e.g., rake components:run["bundle update"]'
  task :run, [:command] do |t, args|
    command = args.command
    if command.nil?
      raise "Usage: rake components:run[<command>]"
    end

    stratify_components.each do |gem_name|
      Dir.chdir(File.join(ROOT, gem_name)) { sh command }
    end
  end

  desc "Run specs for all Stratify components"
  task :spec do
    stratify_components.each do |component_name|
      Dir.chdir(File.join(ROOT, component_name)) { rake_command "spec" }
    end
  end
end

namespace :gems do
  desc "Install all Stratify gems"
  task :install do
    stratify_gems.each do |gem_name|
      Dir.chdir(File.join(ROOT, gem_name)) { ruby "-S rake install" }
    end
  end

  desc "Build all Stratify gems"
  task :build do
    stratify_gems.each do |gem_name|
      Dir.chdir(File.join(ROOT, gem_name)) { gem_command "build", "#{gem_name}.gemspec" }
    end
  end
end

task :default => 'components:spec'
