require 'active_support/core_ext/string'

module GrapeRakeTasks
  class Processor
    attr_reader :routes

    def initialize(routes)
      @routes = routes
    end

    def format(formatter, filter = nil)
      routes_to_display = filter_by_api(filter)
      formatter.construct_output(routes_to_display)
      formatter.result
    end

    def filter_by_api(filter = nil)
      return routes unless filter
      filter_as_class = "#{filter.camelcase}::API"
      routes.select { |r| r.route_api.to_s == filter_as_class }
    end
  end
end
