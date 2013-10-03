Given(/^I've created a service api key$/) do
  puts "open https://mandrillapp.com/settings/add-key"
end

Given /^a rails application$/ do
  FileUtils.mkdir_p(current_dir)
  FileUtils.cp_r('spec/dummy',current_dir+"/dummy")
  cd "dummy"
end
