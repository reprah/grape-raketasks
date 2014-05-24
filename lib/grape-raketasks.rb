require 'grape'
require 'grape-raketasks/route'
require 'grape-raketasks/processor'
require 'grape-raketasks/console_formatter'

module GrapeTasks
  require 'grape-raketasks/railtie' if defined?(Rails)
end

