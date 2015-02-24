set :procfile_path, "#{current_path}/Procfile"
set :dotenv_path, "#{shared_path}/.env"
set :foreman_path, "#{current_path}/.foreman"

namespace :foreman do
  desc "Setup Foreman"
  task :setup_base_files do
    on roles fetch(:foreman_roles) do
      template ".env.erb", fetch(:dotenv_path)
    end
  end

  task :setup do
    invoke :'foreman:update_foreman_file'
    invoke :'foreman:overwrite_procfile'
    invoke :'foreman:export'
    invoke :'foreman:start'
  end
  after "deploy:finished", "foreman:setup"

  desc "Update .foreman file"
  task :update_foreman_file do
    on roles fetch(:foreman_roles) do
      template ".foreman.erb", fetch(:foreman_path)
    end
  end

  desc "Overwrite procfile"
  task :overwrite_procfile do
    on roles fetch(:foreman_roles) do
      template "Procfile.erb", fetch(:procfile_path)
    end
  end

  desc 'Export the Procfile'
  task :export do
    on roles fetch(:foreman_roles) do
      opts = {
        app: fetch(:application),
        log: File.join(shared_path, 'log'),
        user: fetch(:user)
      }.merge fetch(:foreman_options, {})

      execute(:mkdir, "-p", opts[:log])

      execute "cd '#{release_path}' && ~/.rbenv/bin/rbenv sudo bundle exec foreman export #{fetch(:foreman_template)} #{fetch(:foreman_export_path)} #{opts.map { |opt, value| "--#{opt}='#{value}'" }.join(' ')}"
    end
  end

  %w[start stop restart].each do |command|
    desc "#{command} foreman"
    task command do
      on roles fetch(:foreman_roles) do
        execute :sudo, command, fetch(:foreman_app) rescue RuntimeError
      end
    end
  end

  after "deploy:started", "foreman:stop"
end

