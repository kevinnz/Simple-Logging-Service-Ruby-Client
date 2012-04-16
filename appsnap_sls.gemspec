# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name = "appsnap_sls"
  gem.version = "0.1.6"
  gem.authors = ["Tyler Power"]
  gem.email = ["tyler@appsnap.co.nz"]
  gem.description = %q{A Ruby client for the AppSnap Simple Logging Service}
  gem.summary = %q{Can be auto configured via the Cloud Foundry environment and provides asynchronous logging functionality using Event Machine.}
  gem.homepage = "http://appsnapcloud.com"

  gem.add_dependency "json"
  gem.add_dependency "eventmachine"
  gem.add_dependency "em-http-request"

  gem.require_paths = ['lib']
  gem.files = Dir["lib/**/*.rb"]
end
