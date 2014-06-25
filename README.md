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

Require `mina/multistage` in `config/deploy.rb`:

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
$ mina multistage:init
```

It will create `config/deploy/staging.rb` and `config/deploy/production.rb` stage files.
Use them to define stage-specific configuration.

```rb
# config/deploy/staging.rb
set :domain, 'example.com'
set :deploy_to, '/var/www/my_app'
set :repository, 'https://github.com/user/repo'
set :branch, 'master'
set :user, 'www'
set :rails_env, 'staging'
```

Now deploy `staging` with:

```shell
$ mina deploy
```

Or specify a stage explicitly:

```shell
$ mina staging deploy
$ mina production deploy
```


## Configuration

* `stages` - array of stages names, default is names of all `*.rb` files from `stages_dir`
* `stages_dir` - stages files directory, default is `config/deploy`
* `default_stage` - default stage, default is `staging`

If you want to override default values of these options, they should be set before requiring `mina/multistage` file.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
