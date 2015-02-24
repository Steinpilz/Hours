namespace :nginx do
  desc "Install latest stable release of nginx"
  task :install do
    on roles :web do
      execute "add-apt-repository ppa:nginx/stable"
      execute "apt-get -y update"
      execute "apt-get -y install nginx"
    end
  end
  after "deploy:install", "nginx:install"

  desc "Setup nginx configuration for this application"
  task :setup do
    on roles :web do
      template "nginx_unicorn.erb", "/tmp/nginx_conf"
      execute "sudo mv /tmp/nginx_conf /etc/nginx/sites-enabled/#{fetch(:application)}"
      execute "sudo rm -f /etc/nginx/sites-enabled/default"
    end 
  end
  after "deploy:setup", "nginx:setup"
  
  %w[start stop restart].each do |command|
    desc "#{command} nginx"
    task command do
      on roles :web do
        execute "sudo service nginx #{command}"
      end
    end
  end
  after "nginx:setup", "nginx:restart"
end
