require 'active_support/core_ext/string'

module GrapeRakeTasks
  class Processor
    attr_reader :routes

    def initialize(routes)
      @routes = routes
    end

    def format(formatter, filter = nil)
      routes_to_display = filter_by_api(filter)
      formatter.construct_output(routes_to_display, filter)
      formatter.result
    end

    def filter_by_api(filter = nil)
      return routes unless filter
      pattern = Regexp.new(filter, Regexp::IGNORECASE)
      filtered = routes.select do |r|
        matches_filter_pattern?(r, pattern)
      end
      filtered.uniq
    end

    private

    def matches_filter_pattern?(route, pattern)
      # match filter against string representation of a route's API
      api_as_string = route.route_api.to_s
      api_as_string.match(pattern)
    end
  end
end
