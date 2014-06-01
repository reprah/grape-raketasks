require 'active_support/core_ext/string'

module GrapeRakeTasks
  class Processor
    attr_reader :routes

    def initialize(routes)
      @routes = routes
    end

    def format(formatter, filter = nil)
      routes_to_display = filter_by_api(filter)
      constant = filter_to_constant(filter)
      formatter.construct_output(routes_to_display, constant)
      formatter.result
    end

    def filter_by_api(filter = nil)
      return routes unless filter
      constant = filter_to_constant(filter)
      pattern = Regexp.new(constant, Regexp::IGNORECASE)
      filtered = routes.select do |r|
        matches_filter_pattern?(r, pattern)
      end
      filtered.uniq
    end

    private

    def filter_to_constant(filter)
      return unless filter
      parts = filter.split('/')
      parts.map(&:camelcase).join('::')
    end

    def matches_filter_pattern?(route, pattern)
      # match filter against string representation of a route's API
      api_as_string = route.route_api.to_s
      api_as_string.match(pattern)
    end
  end
end
