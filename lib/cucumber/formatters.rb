require 'cucumber/formatter/failures'
require 'cucumber/formatter/rerun_dump'
require 'cucumber/formatter/simplecsv'
require 'cucumber/formatter/simpledoc'
require 'cucumber/cli/main'

# Extend Cucumber's builtin formats, so that all the
# formatters can be used with --format
Cucumber::Cli::Options::BUILTIN_FORMATS['failures'] = [
  'Cucumber::Formatter::Failures',
  'Outputs scenario information and stack trace when a test fails'
]

Cucumber::Cli::Options::BUILTIN_FORMATS['rerundump'] = [
  'Cucumber::Formatter::RerunDump',
  'Outputs scenario file and line number on new lines. For use with --dry-run'
]

Cucumber::Cli::Options::BUILTIN_FORMATS['simpledoc'] = [
  'Cucumber::Formatter::SimpleDoc',
  'Outputs feature, scenario and line number'
]

Cucumber::Cli::Options::BUILTIN_FORMATS['simplecsv'] = [
  'Cucumber::Formatter::SimpleCSV',
  'Outputs feature, scenario and line number in csv format'
]
