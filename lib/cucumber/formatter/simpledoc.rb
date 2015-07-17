require 'term/ansicolor'

require 'cucumber/formatter/io'
require 'cucumber/formatter/console'

module Cucumber
  module Formatter
    # Simple documentation formatter
    class SimpleDoc
      include Cucumber::Formatter::Io
      include Cucumber::Formatter::Console
      include Term::ANSIColor
      attr_reader :runtime

      def initialize(runtime, path_or_io, options)
        @runtime = runtime
        @io      = ensure_io(path_or_io, 'simpledoc')
        @options = options
      end

      def before_features(_features)
        print_profile_information
        @io.puts 'Testing has started...'
        @io.flush
      end

      def after_features(features)
        print_summary(features)
      end

      def before_feature(_feature)
        @background_failure = false
      end

      def feature_name(keyword, name)
        @feature = "#{keyword}: #{name.split("\n")[0]}"
        @io.puts @feature
        @io.flush
      end

      def before_background(_background)
        @in_background = true
      end

      def after_background(_background)
        @in_background = false
      end

      def background_name(keyword, name, *_args)
        @background = "  #{keyword}: #{name}"
        @io.puts @background
        @io.flush
      end

      def scenario_name(keyword, name, file_colon_line, _source_indent)
        @scenario = "  #{keyword}: #{name}"
        @io.puts "#{@scenario}".ljust(75) + yellow(" #{file_colon_line}")
        @io.flush
      end

      def step_name(keyword, step_match, *_args)
        @step = "    #{keyword}#{step_match.format_args}"
      end

      def exception(exception, status, indent = 6)
        unless @background_failure
          print_scenario_summary
          print_exception(exception, status, indent)
          @io.puts
          @io.flush
        end
        @background_failure = @in_background
      end

      def after_table_row(table_row)
        return unless table_row.exception
        @step = "    Row: #{table_row.name}"
        exception(table_row.exception, table_row.status, 6)
      end

      private

      def print_scenario_summary
        @io.puts @step unless @step.nil?
        @io.puts @table_row unless @table_row.nil?
      end

      def print_summary(features)
        @io.puts
        print_stats(features, @options)
        print_snippets(@options)
        print_passing_wip(@options)
      end
    end
  end
end
