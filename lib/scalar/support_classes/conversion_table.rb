module Scalar
  module SupportClasses
    class ConversionTable
      def initialize(base_unit:)
        self.table = {}
        self.base_unit = base_unit
        add(name: base_unit, base_unit_per: 1.to_r)
      end

      def add(name:, base_unit_per:)
        raise unless name.is_a? Symbol

        table[name] = {name => 1.to_r}

        table.keys.each do |k|
          table[k][name] = (table[k][base_unit] / base_unit_per).to_r
          table[name][k] = 1.to_r / table[k][name]
        end
      end

      def call(from:, to:)
        table[from][to]
      end

      attr_accessor :table, :base_unit
    end
  end
end
