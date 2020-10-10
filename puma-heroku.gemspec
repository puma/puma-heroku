# coding: utf-8

d = File.read(File.expand_path("../lib/puma/plugin/heroku.rb", __FILE__))
if d =~ /VERSION = "(\d+\.\d+\.\d+)"/
  version = $1
else
  version = "0.0.1"
end

Gem::Specification.new do |spec|
  spec.name          = "puma-heroku"
  spec.version       = version
  spec.authors       = ["Evan Phoenix"]
  spec.email         = ["evan@phx.io"]

  spec.summary       = %q{Puma integration for Heroku}
  spec.description   = %q{A Puma plugin that contains the default Heroku config}
  spec.homepage      = "https://github.com/puma/puma-heroku"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "puma", ">= 5.0", "< 6.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
end
