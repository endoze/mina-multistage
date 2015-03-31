[![Gem Version](https://badge.fury.io/rb/mina-multistage.png)](http://badge.fury.io/rb/mina-multistage) [![Stories in Ready](https://badge.waffle.io/Endoze/mina-multistage.png?label=ready)](https://waffle.io/Endoze/mina-multistage)  


# Mina::Multistage

Plugin for Mina that adds support for multiple stages.


## Installation & Usage

Add this line to your application's Gemfile:

```rb
gem 'mina-multistage', require: false
```

And then execute:

```shell
$ bundle
```

Or install it yourself as:

```shell
$ gem install mina-multistage
```

Require `mina/multistage` in your `config/deploy.rb`:

```rb
require 'mina/multistage'
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

...

task setup: :environment do
  ...
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  ...
end
```

Then run:

```shell
$ bundle exec mina multistage:init
```

This will create `config/deploy/staging.rb` and `config/deploy/production.rb` stage files.
Use them to define stage specific configuration.

```rb
# config/deploy/staging.rb
set :domain, 'example.com'
set :deploy_to, '/var/www/my_app'
set :repository, 'https://github.com/user/repo'
set :branch, 'master'
set :user, 'www'
set :rails_env, 'staging'
```

If you receive the following error, make sure that you've required 'mina/multistage' in
your `config/deploy.rb`

```shell
$ bundle exec mina multistage:init
mina aborted!
Don't know how to build task 'multistage:init'
```

Now you can deploy the default stage with:

```shell
$ mina deploy # this deploys staging by default
```

Or specify a stage explicitly:

```shell
$ mina staging deploy
$ mina production deploy
```


## Configuration

* `stages` - array of stages names, the default is the name of all `*.rb` files from `stages_dir`
* `stages_dir` - stages files directory, the default is `config/deploy`
* `default_stage` - default stage, the default is `staging`

If you want to override the default values for any of these options, they should be set before requiring `mina/multistage`.

```rb
# config/deploy.rb

set :stages, %w(development test staging production)
set :stages_dir, 'config/deploy_stages'
set :default_stage, 'development'

require 'mina/multistage'
require 'mina/bundler'
require 'mina/rails'
require 'mina/git'

...

task setup: :environment do
  ...
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  ...
end
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
