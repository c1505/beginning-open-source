# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'beginning_open_source/version'

Gem::Specification.new do |spec|
  spec.name          = "beginning_open_source"
  spec.version       = BeginningOpenSource::VERSION
  spec.authors       = ["Corey Morris"]
  spec.email         = ["coreym247@gmail.com"]

  spec.summary       = %q{A tool to find beginner friendly open source issues to work on.}
  spec.description   = %q{A tool to find beginner friendly open source issues to work on.}
  spec.homepage      = "https://github.com/c1505/beginning-open-source"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # spec.bindir        = "exe" #should this be bin?
  spec.bindir        = "bin" #should this be bin?

  # spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) } this was the default, but wasn't working.  trying as below
  spec.executables   = ["beginning-open-source"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.add_dependency "httparty"


end
