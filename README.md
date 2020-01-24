# Fdbq::Rails

A Rails integration of <TBD> with an ORM recording of submits.

## Installation

##### Terminal

`gem install fdbq-rails`

##### Gemfile

`gem 'fdbq-rails'`

##### Rails

Generate configuration files
+ `rails g fdbq:rails:install`

Mount into your application
+ update `config/routes.rb` with `mount Fdbq::Rails::Engine, at: '<your path>'`

Update configuration for fton-end
+ update `config/fdbq.yml` configuration file

## Usage


Aadd to your layout or view plugin
+ `fdbq_render`

To fetch list of submitted responses use
+ `fdbq_responses` helper that works within controller, helper or view.
or
+ `Fdbq::Feedback.all` to query directly thru ActiveRecord model.

## Contributing

- fork it
- commit
- submit PR

## TODO

- [ ] Add JS plugin
- [ ] Add MongoDB support

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
