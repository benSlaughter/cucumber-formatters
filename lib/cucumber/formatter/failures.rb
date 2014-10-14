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

      def before_feature(feature)
        @feature = "Feature: #{feature.title}"
      end

      def before_feature_element(feature_element)
        @exception = false
        @scenario = "  Scenario: #{feature_element.title}"
      end

      def before_step(step)
        @step = "    Step: #{step.name}" unless @exception
      end

      def exception(exception, status)
        @exception = true
        print_scenario_summary
        print_exception(exception, status, 6)
        @io.puts
        @io.flush
      end

      def after_features(features)
        print_summary(features)
      end

      private

      def print_scenario_summary
        @io.puts @feature unless @feature.nil?
        @io.puts @scenario unless @scenario.nil?
        @io.puts @step unless @step.nil?

        @feature, @scenario, @step = nil, nil, nil
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
