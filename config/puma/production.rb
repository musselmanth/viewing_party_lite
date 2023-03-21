
# Change to match your CPU core count
workers 0

# Min and Max threads per worker
threads 1, 6

# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

# Set up socket location
#bind "unix://#{shared_dir}/sockets/puma.sock"
bind "unix:/home/tom/demo_apps/viewing_party_lite/puma.sock"

# Logging
stdout_redirect "/home/tom/demo_apps/viewing_party_lite/log/puma.stdout.log", "/home/tom/demo_apps/viewing_party_lite/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "/home/tom/demo_apps/viewing_party_lite/puma.pid"
state_path "/home/tom/demo_apps/viewing_party_lite/puma.state"
activate_control_app
