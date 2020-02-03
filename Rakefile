desc "Bundle install"
task "bundle_install" do
  sh "make install"
end

desc "Bundle build"
task "bundle_build" do
  sh "make bundle"
end

task :default => ["bundle_install", "bundle_build"]

