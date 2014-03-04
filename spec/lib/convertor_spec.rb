require 'spec_helper'

class TestConvertor
  include DataSmash::Convertor

  convert ->(item, data) {
    return false unless item[:foo]
    data
  }

  # from foo to bar
  convert ->(item, data) {
    data[:bar] = item[:foo]
    data
  }

  # from ping to pong
  convert ->(item, data) {
    data[:pong] = item[:ping]
    data
  }
end

describe DataSmash::Convertor do
  let(:convertor) { TestConvertor.new }
  let(:item) {
    {
      foo: 'baz',
      ping: 'ding'
    }
  }

  describe '#convert' do
    it 'should run the first convertor' do
      data = convertor.convert(item)
      data[:bar].should == item[:foo]
    end

    it 'should run the second convertor' do
      data = convertor.convert(item)
      data[:pong].should == item[:ping]
    end

    context 'given data which causes a convertor to stop' do
      let(:invalid_item) { {ping: 'dong'} }

      it 'should cease processing' do
        data = convertor.convert(invalid_item)
        data.should be_nil
      end
    end
  end
end
