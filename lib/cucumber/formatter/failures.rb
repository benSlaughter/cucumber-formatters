require 'cucumber/formatter/io'
require 'cucumber/formatter/console'

module Cucumber
  module Formatter
    # Failure formatter
    # Will only output information when a test fails
    # The output structure is:
    #
    # Feature title
    #   Scenario title
    #     Step text
    #       Full stacktrace
    #
    class Failures
      include Cucumber::Formatter::Io
      include Cucumber::Formatter::Console
      attr_reader :runtime

      def initialize(runtime, path_or_io, options)
        @runtime = runtime
        @io      = ensure_io(path_or_io, 'failures')
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

      def before_feature(feature)
        @background_failure = false
      end

      def feature_name(keyword, name)
        @feature = "#{keyword}: #{name}"
      end

      def before_background(background)
        @in_background = true
      end

      def after_background(background)
        @in_background = false
      end

      def background_name(keyword, name, file_colon_line, source_indent)
        @background = "  #{keyword}: #{name}"
      end

      def scenario_name(keyword, name, file_colon_line, source_indent)
        @scenario = "  #{keyword}: #{name}"
      end

      def step_name(keyword, step_match, status, source_indent, background, file_colon_line)
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
        if table_row.exception
          @step = "    Row: #{table_row.name}"
          exception(table_row.exception, table_row.status, 6)
        end
      end

      private

      def print_scenario_summary
        @io.puts @feature unless @feature.nil?
        @io.puts (@scenario ? @scenario : @background)
        @io.puts @step unless @step.nil?
        @io.puts @table_row unless @table_row.nil?

        @feature, @background, @scenario, @step = nil, nil, nil, nil
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
