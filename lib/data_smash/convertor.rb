module DataSmash
  module Convertor
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def convert(convertor, opts={})
        @CONVERTORS ||= {}
        @CONVERTORS[convertor] ||= []
        @CONVERTORS[convertor] << opts
      end

      def convertors
        @CONVERTORS
      end
    end

    def convert(item)
      data = {}
      self.class.convertors.each do |convertor, opts|
        data = convertor.call(item, data)
        return unless data
      end
      data
    end
  end
end
