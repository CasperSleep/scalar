require 'scalar/weight'

RSpec.describe Scalar::Weight do
  describe '#succ' do
    it 'increases the scalar by one' do
      expect(described_class.pounds(2).succ).to eq(described_class.pounds(3))
    end
  end

  describe '#<=>' do
    context 'when comparing to a non-weight' do
      it 'returns false' do
        expect(described_class.pounds(1) <=> 5).to eq(nil)
      end
    end
  end

  describe '#+' do
    it 'adds two weights' do
      w1,w2 = described_class.pounds(1), described_class.ounces(32)
      expect(w1 + w2).to eq(described_class.pounds(3))
    end

    it 'raises TypeError if adding a non-weight' do
      obj = Object.new
      error_msg="#{obj.class} can't be coerced into #{described_class}"
      expect{described_class.pounds(1) + obj}.to raise_error(TypeError, error_msg)
    end
  end

  describe '#scalar' do
    it 'returns the unitless numeric amount' do
      expect(described_class.pounds(5).scalar).to eq(5)
    end
  end

  describe '.pounds' do
    subject { described_class.pounds(0) }
    it { is_expected.to be_a(described_class) }
  end

  describe '.ounces' do
    subject { described_class.ounces(0) }
    it { is_expected.to be_a(described_class) }
  end

  describe '.grams' do
    subject { described_class.grams(0) }
    it { is_expected.to be_a(described_class) }
  end

  describe '.kilograms' do
    subject { described_class.kilograms(0) }
    it { is_expected.to be_a(described_class) }
  end

  describe 'conversions' do

    describe '0 pounds' do
      it 'equals 0 pounds' do
        expect(described_class.pounds(0)).to eq(described_class.pounds(0))
      end

      it 'equals 0 ounces' do
        expect(described_class.pounds(0)).to eq(described_class.ounces(0))
      end

      it 'equals 0 grams' do
        expect(described_class.pounds(0)).to eq(described_class.grams(0))
      end

      it 'equals 0 kilograms' do
        expect(described_class.pounds(0)).to eq(described_class.kilograms(0))
      end
    end

    describe '1 pound' do
      it 'equals 1 pound' do
        expect(described_class.pounds(1)).to eq(described_class.pounds(1))
      end

      it 'equals 16 ounces' do
        expect(described_class.pounds(1)).to eq(described_class.ounces(16))
      end

      it 'equals 0 grams' do
        expect(described_class.pounds(1))
          .to be_within(0.00001).percent_of(described_class.kilograms(453.59188070533535))
      end

      it 'equals 0 kilograms' do
        expect(described_class.pounds(1))
          .to be_within(0.00001).percent_of(described_class.kilograms(0.45359188070533535))
      end
    end

    describe '2 pounds' do
      it 'equals 2 pounds' do
        expect(described_class.pounds(2)).to eq(described_class.pounds(2))
      end

      it 'equals 32 ounces' do
        expect(described_class.pounds(2)).to eq(described_class.ounces(32))
      end

      it 'equals 907.18 grams' do
        expect(described_class.pounds(2))
          .to be_within(0.00001).percent_of(described_class.grams(907.1837614106707))
      end

      it 'equals 0.90718 kilograms' do
        expect(described_class.pounds(2))
          .to be_within(0.00001).percent_of(described_class.kilograms(0.9071837614106707))
      end
    end

    describe '4 ounces' do
      it 'equals 4 ounces' do
        expect(described_class.ounces(4)).to eq(described_class.ounces(4))
      end

      it 'equals 0.25 pounds' do
        expect(described_class.ounces(4)).to eq(described_class.pounds(0.25))
      end

      it 'equals ~113 grams' do
        expect(described_class.ounces(4).grams.scalar).to be_within(0.0000000001).of(113.39797017633384)
      end

      it 'equals ~0.113 grams' do
        expect(described_class.ounces(4).kilograms.scalar).to be_within(0.0000000001).of(0.11339797017633384)
      end
    end

    describe '1 kilogram' do
      it 'equals 1000 grams' do
        expect(described_class.kilograms(1).grams).to eq(described_class.grams(1000))
      end
    end

    describe '0.25 pounds' do
      it 'equals 1/4 pounds' do
        expect(described_class.pounds(0.25)).to eq(described_class.pounds(1.to_r/4))
      end

      it 'equals 4 ounces' do
        expect(described_class.pounds(0.25)).to eq(described_class.ounces(4))
      end
    end

    describe '"1/4" ounces' do
      it 'equals 0.25 ounces' do
        expect(described_class.ounces('1/4')).to eq(described_class.ounces(0.25))
      end

      it 'equals 1/64 pounds' do
        expect(described_class.ounces('1/4')).to eq(described_class.pounds(1.to_r/64))
      end
    end
  end
end
