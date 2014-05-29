require 'active_support/core_ext/string'

module GrapeRakeTasks
  class ConsoleFormatter
    attr_reader :buffer

    def initialize
      @buffer = []
    end

    def result
      buffer.join << "\n\n"
    end

    def construct_output(routes)
      if routes.any?
        buffer << routes.map { |r| format_route(r) }.join("\n\n")
      else
        buffer << no_routes_message
      end
    end

    def format_route(route)
      opts = route.options
      # two characters (colon + space) after the title
      longest_key_length = opts.keys.map(&:length).max + 2

      opts.sort.map do |key, value|
        title = key_to_title(key)
        title << build_padding(longest_key_length, key.length)
        title << value.inspect
      end.join("\n")
    end

    private

    def build_padding(max_len, title_len)
      # whitespace padding used to align output
      ' ' * (max_len - title_len)
    end

    def key_to_title(key)
      key.to_s.upcase.concat(': ')
    end

    def no_routes_message
      <<-MSG.strip_heredoc
        You don't have any Grape routes defined!
        Visit https://github.com/intridea/grape for help.
      MSG
    end
  end
end
