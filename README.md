# Scalar
[![Build Status](https://travis-ci.org/CasperSleep/scalar.svg?branch=master)](https://travis-ci.org/CasperSleep/scalar)

What is scalar? It is a thin, performant library for measurement conversions.

## Alternatives

- [Measured](https://github.com/Shopify/measured)
- [RubyMeasurement](https://github.com/mhuggins/ruby-measurement)

## Why Scalar?
- Because it is crazy fast:
```
pry(main)> Benchmark.ips do |r|
pry(main)*   r.report("scalar") { Scalar::Weight.ounces(5).pounds }
pry(main)*   r.report ('measured') { Measured::Weight.new(5, :oz).convert_to(:lb) }
pry(main)*   r.report('r-m') { Measurement.parse("5 oz").convert_to(:lb) }
pry(main)* end
Warming up --------------------------------------
              scalar    54.968k i/100ms
            measured   983.000  i/100ms
                 r-m     2.751k i/100ms
Calculating -------------------------------------
              scalar    661.515k (± 3.6%) i/s -      3.353M in   5.075379s
            measured     10.087k (± 3.1%) i/s -     51.116k in   5.072332s
                 r-m     28.409k (± 4.3%) i/s -    143.052k in   5.044956s
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

