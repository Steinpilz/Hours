server '178.62.181.53', roles: [:web,:app,:db], primary: true, user: fetch(:user)

set :branch, "development"
set :server_name, "hours.appouting.com *.hours.appouting.com"

