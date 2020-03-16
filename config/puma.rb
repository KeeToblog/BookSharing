workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

bind "unix://#{Rails.root}/tmp/sockets/puma.sock"

# デーモン化の設定（アプリを長時間バックグラウンドで常駐させる）
daemonize true
pidfile "#{Dir.pwd}/tmp/pids/puma.pid"
#stdout_redirect "#{Dir.pwd}/tmp/logs/puma.stdout.log", "#{Dir.pwd}/tmp/logs/puma.stderr.log", true

preload_app!

rackup      DefaultRackup
#port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
