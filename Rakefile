stratify_gems = [
  'stratify-base',
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
  sh "#{RUBY} -S gem #{command} #{args.join(' ')}"
end

def rake_command(command)
  sh "#{RUBY} -S rake #{command}"
end

desc "Install all Stratify gems"
task :install do
  stratify_gems.each do |gem_name|
    Dir.chdir(File.join(ROOT, gem_name)) { rake_command "install" }
  end
end

desc "Build all Stratify gems"
task :build do
  stratify_gems.each do |gem_name|
    Dir.chdir(File.join(ROOT, gem_name)) { gem_command "build", "#{gem_name}.gemspec" }
  end
end

desc "Run specs for all Stratify components"
task :spec do
  stratify_components.each do |gem_name|
    Dir.chdir(File.join(ROOT, gem_name)) { rake_command "spec" }
  end
end

task :default => 'spec'
