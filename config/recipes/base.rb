def template(from, to, overwrite: true)
  if overwrite || !test("[ -f #{to} ]")
    erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
    upload! StringIO.new(ERB.new(erb).result(binding)), to
  end
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y install python-software-properties"
  end
  
  task :setup do
  end

  task :restart do
  end

  task :stop do
  end
end
