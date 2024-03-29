set :application, "rubymotion_it"

set :domain,      "rubymotion.it"

# git

# #set :repository,  "svn://#{domain}/svn/#{application}"
# #default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git://github.com/makevoid/#{application}.git"  # public
#set :repository, "ssh+git://git@makevoid.com/git/#{application}"  # private @makevoid.com

set :scm, "git"
set :branch, "master"
set :deploy_via, :remote_cache

set :password, File.read("/Users/makevoid/.password").strip


set :user,        "www-data"

set :use_sudo,    false
set :deploy_to,   "/www/#{application}"


# Uncomment for Github Private repo
#
# default_run_options[:pty] = true  # Must be set for the password prompt from git to work
# set :scm_passphrase, password  # The deploy user's password
# ssh_options[:forward_agent] = true
# set :deploy_via, :remote_cache


# set :scm_username, "makevoid"
# set :scm_password, File.read("/home/www-data/.password").strip

role :app, domain
role :web, domain
role :db,  domain, :primary => true




after :deploy, "deploy:cleanup"
after :deploy, "deploy:create_symlinks"
#after :deploy, "db:seeds"

namespace :deploy do

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Create some symlinks from shared to public"
  task :create_symlinks do
    run "cd #{current_path}/public; ln -s #{deploy_to}/shared/projects_src projects_src"
  end

end

namespace :bundle do
  desc "Install gems with bundler"
  task :install do
    run "cd #{current_path}; bundle install --relock"
  end

  desc "Commit, deploy and install"
  task :installscom do
    `svn commit -m ''`
    `cap deploy`
    `cap bundle:install`
  end
end

# ...

namespace :bundler do
  task :create_symlink, :roles => :app do
    shared_dir = File.join(shared_path, 'bundle')
    release_dir = File.join(current_release, '.bundle')
    run("mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}")
  end

  task :bundle_new_release, :roles => :app do
    bundler.create_symlink
    run "cd #{release_path} && bundle install --without test"
  end

  task :lock, :roles => :app do
    run "cd #{current_release} && bundle lock;"
  end

  task :unlock, :roles => :app do
    run "cd #{current_release} && bundle unlock;"
  end
end

# HOOKS
after "deploy:update_code" do
  bundler.bundle_new_release
  # ...
end

R_ENV = "RACK_ENV"

namespace :scraper do
  desc "Run the scraper"
  task :scrape do
    run "cd #{current_path}; #{R_ENV}=production bundle exec rake scraper:scrape --trace"
  end
end