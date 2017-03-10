app_name = 'qwiznotes'

set :application, app_name
set :repo_url, "git@github.com:greganswer/#{app_name}.git"

set :deploy_to, "/home/deploy/#{app_name}"

append :linked_files, "config/database.yml", "config/secrets.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system", "public/uploads"
