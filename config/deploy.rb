app_name = 'qwiznotes'

set :application, app_name
set :repo_url, "git@github.com:greganswer/#{app_name}.git"

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"

server '67.205.178.172', user: 'deploy', roles: %w{app db web}

task :production do
  set :deploy_to, "/home/deploy/#{app_name}"
end

task :staging do
  set :deploy_to, "/home/deploy/staging.#{app_name}"
  set :branch, 'staging'
end
