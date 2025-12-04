# Puma configuration file.

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

rails_env = ENV.fetch("RAILS_ENV") { "development" }
environment rails_env

# Disable workers entirely on Heroku (required for ActionCable)
# Running Puma in cluster mode breaks WebSockets.
workers 0

# Preload only when workers > 0 (not our case)
# preload_app!

port ENV.fetch("PORT") { 3000 }
pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

plugin :tmp_restart
