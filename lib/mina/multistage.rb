require 'fileutils'

location = fetch(:stage_dir, 'config/deploy')

unless exists?(:stages)
  set :stages, Dir["#{location}/*.rb"].map { |f| File.basename(f, '.rb') }
end

stages.each do |name|
  desc "Set the target stage to `#{name}'."
  task(name) do
    set :stage, name.to_sym
    file = "#{location}/#{stage}.rb"
    load file
  end
end

namespace :multistage do
  desc 'Create staging and production stage files'
  task :init do
    Dir.mkdir_p location if !File.exists? location
    %w{staging production}.each do |stage|
      stagefile = File.join(location, "#{stage}.rb")
      if !File.exists?(stagefile)
        File.open(stagefile, 'w') do |f|
          f.puts "set :domain, ''"
          f.puts "set :deploy_to, ''"
          f.puts "set :repository, ''"
          f.puts "set :branch, ''"
          f.puts "set :user, ''"
          f.puts "set :rails_env, '#{stage}'"
        end
      end
    end
  end
end
