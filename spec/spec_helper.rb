$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'scalar'

RSpec.shared_examples 'delegates to #scalar' do |meth|
  it 'delegates to #scalar' do
    expect(subject.send(meth)).to eq subject.scalar.send(meth)
  end
end
