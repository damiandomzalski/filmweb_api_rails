require 'rspec/core/rake_task'
require 'bundler/gem_tasks'
require 'rake/file_list'

Rake::FileList['**/*'].exclude(*File.read('.gitignore').split)
RSpec::Core::RakeTask.new(:spec)
task default: :spec
