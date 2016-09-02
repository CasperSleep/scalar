require 'scalar/support_classes/conversion_table'
require 'scalar/support_classes/measurement'

module Scalar
  class Weight
    include SupportClasses::Measurement

    self.alias_map = {
      pounds: %i(pound  lbs  lb),
      ounces: %i(ounce  ozs  oz),
      kilograms: %i(kilogram  kg),
      grams: %i(gram  gm  g),
    }

    CONVERSIONS = SupportClasses::ConversionTable.new(base_unit: :grams)
    CONVERSIONS.add name: :kilograms, base_unit_per: 1000
    CONVERSIONS.add name: :ounces, base_unit_per: 1.to_r / 0.035274
    CONVERSIONS.add name: :pounds, base_unit_per: 16.to_r / 0.035274
  end
end
