# -*- encoding: utf-8 -*-
require File.expand_path('../lib/clusterable', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'clusterable'
  s.version     = Clusterable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Tom-Eric Gerritsen']
  s.email       = ['tomeric@eet.nu']
  s.homepage    = 'http://github.com/eet-nu/clusterable'
  s.summary     = 'Create clusters of points.'
  s.description = 'Create clusters of points.'
  
  s.files        = Dir["{benchmark,lib,spec}/**/*"] + ["LICENSE", "Rakefile", "Gemfile", "README.md"]
  s.executables  = Dir["bin/*"]
  s.require_path = 'lib'
end
