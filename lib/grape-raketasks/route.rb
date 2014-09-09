require 'active_support/core_ext/class'

# enable adding the API name to a route's options
module Grape
  class Route
    attr_accessor :options
  end
end

module GrapeRakeTasks
  class Route
    def self.all_routes(api)
      api.subclasses.flat_map do |klass|
        api_routes(klass)
      end
    end

    def self.api_routes(api)
      api.routes.map do |grape_route|
        route_with_api_name(grape_route, api)
      end
    end

    def self.route_with_api_name(grape_route, api_name)
      route = grape_route.dup
      new_opts = route.options.merge(api: api_name)
      route.options = new_opts
      route
    end
  end
end
