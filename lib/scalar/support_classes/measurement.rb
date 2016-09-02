module Scalar
  module SupportClasses
    module Measurement
      include Comparable

      module ClassMethods
        def alias_map=(alias_map)
          alias_map.each do |name,aliases|
            define_factory_method(name)
            define_conversion_method(name)
            define_conversion_aliases(name, aliases)
          end
        end

        def define_factory_method(name)
          define_singleton_method(name) {|scalar| new(scalar, name) }
        end

        def define_conversion_method(name)
          define_method(name) { convert(from: unit, to: name) }
        end

        def define_conversion_aliases(name, aliases)
          aliases.each {|aka| alias_method aka, name }
        end
      end

      def self.included(base)
        base.extend ClassMethods
        # .new is not a necessary public method
        base.private_class_method :new
      end

      def <=>(other)
        return nil unless other.is_a?(self.class)
        scalar <=> other.send(unit).scalar
      end

      # this is part of making Weight ranges work.
      def succ
        self.class.send(unit, scalar + 1)
      end

      def -(other)
        if !other.is_a?(self.class)
          raise TypeError, "#{other.class} can't be coerced into #{self.class}"
        end

        self.class.send(unit, scalar - other.send(unit).scalar)
      end

      def +(other)
        if !other.is_a?(self.class)
          raise TypeError, "#{other.class} can't be coerced into #{self.class}"
        end

        self.class.send(unit, scalar + other.send(unit).scalar)
      end

      def initialize(scalar, unit)
        self.scalar = scalar.to_r
        self.unit = unit
      end

      def inspect
        hex_id = (object_id << 1).to_s(16).rjust(14, '0')
        "#<#{self.class.name}:0x#{hex_id}  #{scalar.to_f} #{unit}>"
      end

      attr_reader :scalar
      alias abs scalar

      protected
      attr_reader :unit

      private
      attr_writer :unit, :scalar

      def convert(from:, to:)
        converted_scalar = self.class::CONVERSIONS.call(from: from, to: to) * scalar
        self.class.send(to, converted_scalar)
      end

    end
  end
end
