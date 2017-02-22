require 'cucumber/formatter/io'

module Cucumber
  module Formatter
    # Works like rerun but just outputs file location and line number
    # Each new test is output to a new line
    class RerunDump
      include Cucumber::Formatter::Io

      def initialize(_runtime, path_or_io, options)
        @io = ensure_io(path_or_io, 'rundump')
        @results = []
        @options = options
      end

      def after_test_case(test_case, _result)
        @results << [test_case.location.file, test_case.location.line]
      end

      def done
        return if @results.empty?
        @io.print file_failures.join("\n")
      end

      [:before_test_case, :before_test_step, :after_test_step].each do |method|
        define_method(method) { |*| }
      end

      private

      def file_failures
        @results.map { |file, lines| [file, lines].join(':') }
      end
    end
  end
end
