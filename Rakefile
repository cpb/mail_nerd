ENV['RAILS_ROOT'] ||= 'spec/dummy'
require File.expand_path('spec/dummy/config/application')

Dir.glob("lib/tasks/**.rake").each do |path| load(path) end

Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end


task default: [:test,:cucumber]
