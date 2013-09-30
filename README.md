[![Gem Version](https://badge.fury.io/rb/mina-multistage.png)](http://badge.fury.io/rb/mina-multistage) [![Stories in Ready](https://badge.waffle.io/Endoze/mina-multistage.png?label=ready)](https://waffle.io/Endoze/mina-multistage)  

# Mina::Multistage

Plugin for Mina that adds support for multiple stages.

## Installation

Add this line to your application's Gemfile:

```rb
gem 'mina-multistage', required: false
```

And then execute:

```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install mina-multistage
```

And finally add this line to your config/deploy.rb:

```rb
require 'mina/multistage'
```

## Usage

A sample config/deploy.rb could look something like this:


```rb
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/multistage'

set :shared_paths, ['config/database.yml', 'log', 'tmp/sockets', 'pid/pids']

task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]

  queue! %[mkdir -p "#{deploy_to}/shared/tmp/sockets"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/tmp/sockets"]

  queue! %[mkdir -p "#{deploy_to}/shared/pid/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/pid/pids"]

  queue! %[touch "#{deploy_to}/shared/config/database.yml"]
  queue  %[#-----> Be sure to edit 'shared/config/database.yml'.]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'

    to :launch do
      queue "bundle exec thin restart -C #{deploy_to}/shared/config/thin.yml"
    end
  end
end
```

And a sample development.rb stagefile:
```rb
set :domain, 'localhost'
set :deploy_to, '/var/www/my_app'
set :repository, 'https://github.com/gitlabhq/gitlabhq'
set :branch, '6-1-stable'
set :user, 'deploy'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
