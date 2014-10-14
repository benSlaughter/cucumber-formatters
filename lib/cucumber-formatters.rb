require 'cucumber/formatter/failures'
require 'cucumber/cli/main'

# Extend Cucumber's builtin formats, so that all the
# formatters can be used with --format
Cucumber::Cli::Options::BUILTIN_FORMATS['failures'] = [
  'Cucumber::Formatter::Failures',
  'Outputs scenario information and stack trace when a test fails'
]
