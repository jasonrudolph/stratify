stratify_gems = [
  'stratify-base',
  'stratify-foursquare',
  'stratify-garmin',
  'stratify-github',
  'stratify-gowalla',
  'stratify-instapaper',
  'stratify-itunes',
  'stratify-rhapsody',
  'stratify-twitter',
]

stratify_components = stratify_gems + ['stratify-rails']

ROOT = File.dirname(__FILE__)

def in_each_dir(dirs, &command)
  dirs.each do |dir_name|
    Dir.chdir(File.join(ROOT, dir_name)) { command.call }
  end
end

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

    in_each_dir(stratify_components) { sh command }
  end

  desc "Run specs for all Stratify components"
  task :spec do
    in_each_dir(stratify_components) { rake_command "spec" }
  end
end

namespace :gems do
  desc "Install all Stratify gems"
  task :install do
    in_each_dir(stratify_gems) { ruby "-S rake install" }
  end

  desc "Build all Stratify gems"
  task :build do
    stratify_gems.each do |gem_name|
      Dir.chdir(File.join(ROOT, gem_name)) { gem_command "build", "#{gem_name}.gemspec" }
    end
  end
end

task :default => 'components:spec'
