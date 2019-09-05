# puma-heroku

A Puma plugin with best-practices configuration and handy configuration
variables for Heroku deployments.

You can read Heroku's documentation on the topic [here](https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server). Most of the ideas there apply to all ruby apps running on Puma. Important Note: In that article, Heroku uses a different (rails-specific) environment variable for configuring threads. This plugin uses the generic `MAX_THREADS`, but will use `RAILS_MAX_THREADS` if available.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'puma-heroku'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install puma-heroku


## Usage

Read about how to configure puma to use this plugin here: https://github.com/puma/puma#plugins

There are two variables this plugin reads from the environment which control its behavior.

* `WEB_CONCURRENCY` — How many workers to run. This will be ignored on JRuby and Windows, where only 1 worker will be run.
* `MAX_THREADS` — The number of threads to run per worker. Note that this also sets the minimum number of threads to the same value, which is a recommended approach, especially in a single-app environment such as Heroku. If you are using Rails, you may want to use `RAILS_MAX_THREADS` instead, which is also supported.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
