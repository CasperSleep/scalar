# Scalar
[![Build Status](https://travis-ci.org/CasperSleep/scalar.svg?branch=master)](https://travis-ci.org/CasperSleep/scalar)

What is scalar? It is a thin, performant library for measurement conversions.

## Table of Contents
1. [Installation](#installation)
2. [Usage](#usage)
3. [Developmant](#development)

## Alternatives

- [Measured](https://github.com/Shopify/measured)
- [RubyMeasurement](https://github.com/mhuggins/ruby-measurement)
- [Ruby Units](https://github.com/olbrich/ruby-units)

## Why Scalar?
- Because it is crazy fast:
```
Benchmark.ips do |r|
  r.report("scalar") { Scalar::Weight.pounds(1) == Scalar::Weight.grams(1) }
  r.report("measured") { Measured::Weight.new(1, :lb) == Measured::Weight.new(1, :g) }
  r.report("r-measurement") { Measurement.parse("1 lb") == Measurement.parse("1 g") }
  r.report("ruby-unit") { Unit.new("1 lb") == Unit.new("1 g") }
end

Calculating -------------------------------------
              scalar    459.099k (± 1.1%) i/s -      2.299M in   5.007574s
            measured     15.573k (±17.0%) i/s -     75.900k in   5.035022s
       r-measurement     21.154k (± 1.8%) i/s -    105.850k in   5.005499s
           ruby-unit      2.630k (± 1.5%) i/s -     13.150k in   5.002066s
```

- Because it uses a nice method based interface.
`Scalar::Weight.grams(5).kilograms.scalar == 0.005`

## Why not Scalar?
- Because you are parsing weights from string input.
- Because you need the accuracy of BigDecimal.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'scalar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install scalar

## Usage

### Current measurement types:
Scalar::Weight `require 'scalar/weight'`
- grams, kilograms, pounds, ounces

Scalar::Length `require 'scalar/length'`
- millimeters, meters, kilometers, inches, feet, yards, miles

### Creating a new measurement object
`Scalar::Weight.grams(5) #=> <Scalar::Weight @scalar=5 @unit=:grams>`

### Converting a measurement to a different unit
```
m = Scalar::Weight.grams(5)
m.kilograms
#=> <Scalar::Weight @scalar=0.005 @unit=:kilograms>
m.pounds
#=> <Scalar::Weight @scalar=0.02 @unit=:pounds>
```

### Comparing two measurements
```
Scalar::Weight.grams(5) == Scalar::Weight.kilograms(0.005)
Scalar::Weight.pounds(1) > Scalar::Weight.ounces(1)
```

### Making a new unit type for an existing measurement type
Find base unit:

`Scalar::Weight::CONVERSIONS.base_unit`

Find the conversion ratio online between the new unit and the base unit and add it with the following:
```
Scalar::Weight::CONVERSIONS.add name: :metric_tons, base_units_per: 1_000_000
Scalar::Weight::CONVERSIONS.add name: :stone, base_units_per: 6350.29
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CasperSleep/scalar. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

