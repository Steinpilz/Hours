namespace :postgresql do
  desc "Install the latest stable release of PostgreSQL."
  task :install do
    on roles :db do
      execute "#{sudo} add-apt-repository ppa:pitti/postgresql"
      execute "#{sudo} apt-get -y update"
      execute "#{sudo} apt-get -y install postgresql libpq-dev"
    end

  end
  after "deploy:install", "postgresql:install"

  desc "Generate the database.yml configuration file."
  task :setup do
    on roles :app do
      execute "mkdir -p #{shared_path}/config"
      template "postgresql.yml.erb", "#{shared_path}/config/database.yml"
    end
  end
  after "deploy:setup", "postgresql:setup"

  desc "Symlink the database.yml file into latest release"
  task :symlink do
    on roles :app do
      execute "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
  end
  after "deploy:updated", "postgresql:symlink"
end
