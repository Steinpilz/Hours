server '5.101.106.130', roles: [:web,:app,:db], primary: true, user: fetch(:user)

set :branch, "development"
set :server_name, "logwork.stein-pilz.com"

