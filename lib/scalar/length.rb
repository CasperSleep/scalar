require 'scalar/support_classes/conversion_table'
require 'scalar/support_classes/measurement'

module Scalar
  class Length
    include SupportClasses::Measurement

    self.alias_map = {
      meters: %i(m),
      kilometers: %i(km),
      centimeters: %i(cm),
      millimeters: %i(mm),
      feet: %i(ft),
      inches: %i(in),
      miles: %i(mi),
      yards: %i(yd),
    }

    CONVERSIONS = SupportClasses::ConversionTable.new(base_unit: :meters)
    CONVERSIONS.add name: :kilometers, base_unit_per: 1000
    CONVERSIONS.add name: :centimeters, base_unit_per: 0.01
    CONVERSIONS.add name: :millimeters, base_unit_per: 0.001
    CONVERSIONS.add name: :feet, base_unit_per: 0.3048
    CONVERSIONS.add name: :inches, base_unit_per: 0.3048 / 12
    CONVERSIONS.add name: :miles, base_unit_per: 0.3048 * 5280
    CONVERSIONS.add name: :yards, base_unit_per: 0.3048 * 3
  end
end
