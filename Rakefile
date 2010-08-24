require 'rake'
require 'spec/rake/spectask'

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new do |t|
    t.spec_files = FileList['spec/**/*.rb']
    t.rcov = true
    t.rcov_opts += ['--exclude', 'spec,lib/dao']
end

desc "irb with libraries loaded"
task :repl do
  exec 'irb -I lib -r config -r mingle_mover'
end

task :default => :spec
