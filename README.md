# puma-heroku

This gem is being sunset. Puma 5.0+ now configures Puma in most of the ways that this plugin did.

## Removing this gem from your Gemfile 

1. Upgrade to Puma 5.0.
2. Add `c.port ENV['PORT'] || 3000` to your Puma config file, or `-p ${PORT:-3000}` to your `puma` invocation in your Procfile.
3. Remove this gem.

## More Notes on Upgrading from 1.0

In 1.x, this plugin set `workers` to `1` if WEB_CONCURRENCY is not set. However, this isn't optimal, as it creates a master and worker process, when instead we could just use single mode (`workers 0`) and save memory. 2.x of this plugin uses the Puma 5 default, which is `workers 0` if `WEB_CONCURRENCY` is not set.

If you are using Rails 4.0 or less, you will have to [add your own `on_worker_boot` block.](https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot), it has been removed.

As of Puma 5.0/this plugin 2.x, all this gem does is set the port to `ENV["PORT"]`. In Puma 6.0, Puma will listen to `ENV["PORT"]` by default, and this plugin will receive no further updates (because all of its changes will be merged into the Puma default config).

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
