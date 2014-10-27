Given(/^this step passes$/) do
  # do nothing and it will pass
end

Given(/^this step fails$/) do
  fail 'This step fails'
end

Given(/^this step fails on tag$/) do
  fail 'this step is tagged failure' if @failure
end

Given(/^this step passes (\d+)$/) do |_arg1|
  # do nothing and it will pass
end

Given(/^this step fails (\d+)$/) do |_arg1|
  fail 'this fails'
end

Given(/^this step will (.*)$/) do |result|
  fail 'this step was told to fail' if result == 'fail'
end
