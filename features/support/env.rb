require 'cucumber-formatters'

Before('@fail') do
  @failure = true
end