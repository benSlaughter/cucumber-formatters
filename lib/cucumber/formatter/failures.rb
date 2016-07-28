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
      include Console
      include Io
      attr_writer :indent
      attr_reader :runtime

      def initialize(runtime, path_or_io, options)
        @runtime = runtime
        @io = ensure_io(path_or_io)
        @options = options
        @exceptions = []
        @indent = 0
        @prefixes = options[:prefixes] || {}
        @delayed_messages = []
        @previous_step_keyword = nil
        @snippets_input = []
        @output = []
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
        simple_name = name.split("\n").first
        @feature = "#{keyword}: #{simple_name}"
      end

      def before_background(_background)
        @in_background = true
      end

      def after_background(_background)
        @in_background = false
      end

      def background_name(keyword, name, *_args)
        simple_name = name.split("\n").first
        @background = "  #{keyword}: #{simple_name}"
      end

      def scenario_name(keyword, name, *_args)
        simple_name = name.split("\n").first
        @scenario = "  #{keyword}: #{simple_name}"
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
        @table_row = "    Row: #{table_row.name}"
        exception(table_row.exception, table_row.status, 6)
      end

      def after_test_step(test_step, result)
        collect_snippet_data(test_step, result)
      end

      private

      def print_scenario_summary
        @io.puts @feature unless @feature.nil?
        @io.puts @scenario ? @scenario : @background
        @io.puts @step unless @step.nil?
        @io.puts @table_row unless @table_row.nil?

        @feature = nil
        @background = nil
        @scenario = nil
        @step = nil
        @table_row = nil
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
