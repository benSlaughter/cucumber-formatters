Given(/^this step passes$/) do
  # do nothing and it will pass
end

Given(/^this step fails$/) do
  fail 'This step fails'
end

Given(/^this step fails on tag$/) do
  fail 'this step is tagged failure' if @failure
end

Given(/^this step passes (\d+)$/) do |arg1|
  # do nothing and it will pass
end

Given(/^this step fails (\d+)$/) do |arg1|
  fail 'this fails'
end

Given(/^this step will (.*)$/) do |arg1|
  fail 'this step was told to fail' if arg1 == 'fail'
end