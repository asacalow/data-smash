require 'spec_helper'

class MyConvertor
  include DataSmash::Convertor

  convert ->(item, data) {
    data[:bar] = item[:foo]
    data
  }
end

class TestProcessor
  include DataSmash::Processor

  process_with MyConvertor

  smash_in -> {
    [{foo: 'ding'}, {foo: 'dong'}].each {|d| process d }
  }

  smash_out ->(data) {
    TestProcessor.PROCESSED_DATA ||= []
    TestProcessor.PROCESSED_DATA << data
  }

  class << self
    attr_accessor :PROCESSED_DATA
  end
end

describe DataSmash::Processor do
  describe '#process!' do
    it 'should process each of the things yielded by the in method' do
      TestProcessor.process!
      TestProcessor.PROCESSED_DATA.should =~ [{bar: 'ding'}, {bar: 'dong'}]
    end
  end
end
