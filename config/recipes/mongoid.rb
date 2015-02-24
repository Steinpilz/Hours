set :mongo_host, "localhost:27017"
set :mongo_db_name, ask("Mongo database name: ", "locomotive_#{fetch(:stage)}")

namespace :mongo do

  desc "Generate the database.yml configuration file."
  task :setup do
    on roles :app do
      execute "mkdir -p #{shared_path}/config"
      template "mongoid.yml.erb", "#{shared_path}/config/mongoid.yml"
    end
  end
  after "deploy:setup", "mongo:setup"

  desc "Symlink the database.yml file into latest release"
  task :symlink do
    on roles :app do
      execute "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
    end
  end
  after "deploy:updated", "mongo:symlink"
end
