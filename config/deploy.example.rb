require "bundler/capistrano"
require "whenever/capistrano"

set :application, "stratify"
set :repository,  "git://github.com/your-username-here/stratify.git"

set :domain, "example.com"
role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :user, "deploy"
set :use_sudo, false
set :keep_releases, 5
set :ssh_options, { :forward_agent => true }
default_run_options[:pty] = true

set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via, "remote_cache_with_project_root"
set :project_root, "stratify-rails"
set :copy_cache, true
set :copy_exclude, [".git"]
set :copy_compression, :bz2

set :scm, :git
set :scm_verbose, true
set(:current_branch) { `git branch`.match(/\* (\S+)\s/m)[1] || raise("Couldn't determine current branch") }
set :branch, defer { current_branch }

after "deploy:update_code", "stratify:symlink_configs", "deploy:migrate"
after "deploy", "deploy:tag_last_deploy"
after "deploy:restart", "deploy:cleanup"
set :rails_env, "production"

set :whenever_command, "bundle exec whenever"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :tag_last_deploy do
    timestamp_string_without_seconds = Time.now.strftime("%Y%m%d%H%M")
    set :tag_name, "deployed_to_#{rails_env}_#{timestamp_string_without_seconds}"
    `git tag -a -m "Tagging deploy to #{rails_env} at #{timestamp_string_without_seconds}" #{tag_name} #{branch}`
    run "date > #{current_path}/DEPLOY_TIME"

    puts "Tagged release with #{tag_name}."
  end
end

namespace :stratify do
  task :symlink_configs do
    shared_configs = File.join(shared_path, 'config')
    release_configs = File.join(release_path, 'config')
    run("ln -nfs #{shared_configs}/mongoid.yml #{release_configs}/mongoid.yml")
  end
end
