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

      # Not necessary in Rails 5.2+, see https://github.com/rails/rails/pull/29807
      if defined?(::ActiveRecord) && defined?(::ActiveRecord::Base) && Gem::Version.new(Rails.version) < Gem::Version.new('5.2.0')
        c.before_fork { ActiveRecord::Base.connection_pool.disconnect! }
        c.on_worker_boot { ActiveRecord::Base.establish_connection }
      end

      if defined?(::Sequel)
        c.before_fork { Sequel::DATABASES.each(&:disconnect) }
      end
    end
  end

  VERSION = "1.1.0"
end
