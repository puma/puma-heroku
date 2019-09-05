Puma::Plugin.create do
  def config(c)
    workers_count = Integer(ENV['WEB_CONCURRENCY'] || 1)
    threads_count = Integer(ENV['RAILS_MAX_THREADS'] || ENV['MAX_THREADS'] || 5)
    c.threads threads_count, threads_count

    c.port        ENV['PORT']     || 3000
    c.environment ENV['RACK_ENV'] || ENV['RAILS_ENV'] || 'development'

    if workers_supported? && workers_count > 1
      c.preload_app!
      c.workers workers_count

      c.before_fork do
        if defined?(::ActiveRecord) && defined?(::ActiveRecord::Base)
          ActiveRecord::Base.connection_pool.disconnect!
        end
      end
      c.on_worker_boot do
        if defined?(::ActiveRecord) && defined?(::ActiveRecord::Base)
          # Worker specific setup for Rails 4.1+
          # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
          ActiveRecord::Base.establish_connection
        end
      end
    end
  end

  VERSION = "1.0.0"
end
