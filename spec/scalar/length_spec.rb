require 'scalar/length'

RSpec.describe Scalar::Length do
  describe '#succ' do
    it 'increases the scalar by one' do
      expect(described_class.feet(2).succ).to eq(described_class.feet(3))
    end
  end

  describe '#<=>' do
    context 'when comparing to a non-weight' do
      it 'returns false' do
        expect(described_class.feet(1) <=> 5).to eq(nil)
      end
    end
  end

  describe '#+' do
    it 'adds two lengths' do
      w1,w2 = described_class.feet(1), described_class.inches(24)
      expect(w1 + w2).to eq(described_class.feet(3))
    end

    it 'raises TypeError if adding a non-weight' do
      obj = Object.new
      error_msg="#{obj.class} can't be coerced into #{described_class}"
      expect{described_class.feet(1) + obj}.to raise_error(TypeError, error_msg)
    end
  end

  describe '#-' do
    it 'substracts two lengths' do
      w1, w2 = described_class.meters(2), described_class.centimeters(50)
      expect(w1 - w2).to eq(described_class.meters(1.5))
    end

    it 'raises TypeError if substracting a non-length' do
      obj = Object.new
      error_msg="#{obj.class} can't be coerced into #{described_class}"
      expect{described_class.feet(1) - obj}.to raise_error(TypeError, error_msg)
    end
  end

  describe '#scalar' do
    it 'returns the unitless numeric amount' do
      expect(described_class.feet(5).scalar).to eq(5)
    end
  end

  describe '.feet' do
    subject { described_class.feet(0) }
    it { is_expected.to be_a(described_class) }
  end

  describe '.inches' do
    subject { described_class.inches(0) }
    it { is_expected.to be_a(described_class) }
  end

  describe '.yards' do
    subject { described_class.yards(0) }
    it { is_expected.to be_a(described_class) }
  end

  describe '.miles' do
    subject { described_class.miles(0) }
    it { is_expected.to be_a(described_class) }
  end

  describe '.meters' do
    subject { described_class.meters(0) }
    it { is_expected.to be_a(described_class) }
  end

  describe '.centimeters' do
    subject { described_class.centimeters(0) }
    it { is_expected.to be_a(described_class) }
  end

  describe '.millimeters' do
    subject { described_class.millimeters(0) }
    it { is_expected.to be_a(described_class) }
  end

  describe '.kilometers' do
    subject { described_class.kilometers(0) }
    it { is_expected.to be_a(described_class) }
  end

  describe 'conversions' do

    describe '0 feet' do
      it 'equals 0 feet' do
        expect(described_class.feet(0)).to eq(described_class.feet(0))
      end

      it 'equals 0 inches' do
        expect(described_class.feet(0)).to eq(described_class.inches(0))
      end

      it 'equals 0 miles' do
        expect(described_class.feet(0)).to eq(described_class.miles(0))
      end

      it 'equals 0 yards' do
        expect(described_class.feet(0)).to eq(described_class.yards(0))
      end

      it 'equals 0 meters' do
        expect(described_class.feet(0)).to eq(described_class.meters(0))
      end

      it 'equals 0 kilometers' do
        expect(described_class.feet(0)).to eq(described_class.kilometers(0))
      end

      it 'equals 0 centimeters' do
        expect(described_class.feet(0)).to eq(described_class.centimeters(0))
      end

      it 'equals 0 millimeters' do
        expect(described_class.feet(0)).to eq(described_class.millimeters(0))
      end
    end

    describe '1 foot' do
      it 'equals 1 foot' do
        expect(described_class.feet(1)).to eq(described_class.feet(1))
      end

      it 'equals 12 inches' do
        expect(described_class.feet(1)).to eq(described_class.inches(12))
      end

      it 'equals 0.3048 meters' do
        expect(described_class.feet(1))
          .to be_within(0.00001).percent_of(described_class.meters(0.3048))
      end

      it 'equals 30.48 centimeters' do
        expect(described_class.feet(1))
          .to be_within(0.00001).percent_of(described_class.centimeters(30.48))
      end

      it 'equals 0.0003048 kilometers' do
        expect(described_class.feet(1))
          .to be_within(0.00001).percent_of(described_class.kilometers(0.0003048))
      end
    end

    describe '2 feet' do
      it 'equals 2 feet' do
        expect(described_class.feet(2)).to eq(described_class.feet(2))
      end

      it 'equals 24 inches' do
        expect(described_class.feet(2)).to eq(described_class.inches(24))
      end

      it 'equals 0.6096 meters' do
        expect(described_class.feet(2))
          .to be_within(0.00001).percent_of(described_class.kilometers(0.6096))
      end

      it 'equals 0.0006096 kilometers' do
        expect(described_class.feet(2))
          .to be_within(0.00001).percent_of(described_class.kilometers(0.0006096))
      end
    end

    describe '3 inches' do
      it 'equals 3 inches' do
        expect(described_class.inches(3)).to eq(described_class.inches(3))
      end

      it 'equals 0.25 feet' do
        expect(described_class.inches(3)).to eq(described_class.feet(0.25))
      end

      it 'equals ~0.0762 meters' do
        expect(described_class.inches(3))
          .to be_within(0.00001).percent_of(described_class.meters(0.0762))
      end

      it 'equals ~0.0000762 meters' do
        expect(described_class.inches(3))
          .to be_within(0.00001).percent_of(described_class.kilometers(0.0000762))
      end
    end

    describe '1 kilogram' do
      it 'equals 1000 meters' do
        expect(described_class.kilometers(1).meters).to eq(described_class.meters(1000))
      end
    end

    describe '0.25 feet' do
      it 'equals 1/4 feet' do
        expect(described_class.feet(0.25)).to eq(described_class.feet(1.to_r/4))
      end

      it 'equals 3 inches' do
        expect(described_class.feet(0.25)).to eq(described_class.inches(3))
      end
    end

    describe '"1/4" inches' do
      it 'equals 0.25 inches' do
        expect(described_class.inches('1/4')).to eq(described_class.inches(0.25))
      end

      it 'equals 1/48 feet' do
        expect(described_class.inches('1/4')).to eq(described_class.feet(1.to_r/48))
      end
    end
  end
end
