Puma::Plugin.create do
  def config(c)

    threads_count = Integer(ENV['MAX_THREADS'] || 5)
    c.threads threads_count, threads_count

    c.preload_app!

    c.port        ENV['PORT']     || 3000
    c.environment ENV['RACK_ENV'] || 'development'

    if workers_supported?
      c.workers Integer(ENV['WEB_CONCURRENCY'] || 2)

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
