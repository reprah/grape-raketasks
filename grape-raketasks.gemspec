require File.dirname(__FILE__) + '/lib/grape-raketasks/version'

Gem::Specification.new do |gem|
  gem.name        = 'grape-raketasks'
  gem.version     = GrapeRakeTasks::VERSION

  gem.homepage    = 'https://github.com/reprah/grape-raketasks'
  gem.license     = 'MIT'
  gem.summary     = 'Rake tasks for web applications using Grape APIs.'
  gem.description = 'Provides rake tasks to ease the development and debugging of Grape APIs.'
  gem.author      = 'H. Henn'

  gem.files = `git ls-files`.split($OUTPUT_RECORD_SEPARATOR)
  gem.test_files = gem.files.grep(/^spec/)

  gem.add_runtime_dependency 'grape'
  gem.add_runtime_dependency 'rake'
  gem.add_runtime_dependency 'activesupport'

  gem.add_development_dependency 'rspec'
end
