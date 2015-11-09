require 'cucumber/formatter/io'
require 'cucumber/formatter/console'

module Cucumber
  module Formatter
    # Simple CSV formatter
    class SimpleCSV
      include Cucumber::Formatter::Io
      include Cucumber::Formatter::Console
      attr_reader :runtime

      def initialize(runtime, path_or_io, options)
        @runtime = runtime
        @io      = ensure_io(path_or_io)
        @options = options
      end

      def feature_name(keyword, name)
        @feature = "#{keyword}: #{name.split("\n")[0]}"
        @io.puts @feature
        @io.flush
      end

      def scenario_name(keyword, name, file_colon_line, _source_indent)
        @scenario = "#{keyword}: #{name}"
        @io.puts "#{@scenario},#{file_colon_line}"
        @io.flush
      end
    end
  end
end
