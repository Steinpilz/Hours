namespace :postgresql do
  desc "Install the latest stable release of PostgreSQL."
  task :install, only: {primary: true} do
    on roles :db do
      run "#{sudo} add-apt-repository ppa:pitti/postgresql"
      run "#{sudo} apt-get -y update"
      run "#{sudo} apt-get -y install postgresql libpq-dev"
    end

  end
  after "deploy:install", "postgresql:install"

  desc "Generate the database.yml configuration file."
  task :setup do
    on roles :app do
      run "mkdir -p #{shared_path}/config"
      template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
    end
  end
  after "deploy:setup", "postgresql:setup"

  desc "Symlink the database.yml file into latest release"
  task :symlink do
    on roles :app do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end
  after "deploy:finalize_update", "postgresql:symlink"
end
