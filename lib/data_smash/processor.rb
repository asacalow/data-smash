module DataSmash
  module Processor
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def smash_in(in_proc)
        @IN_PROC = in_proc
      end

      def smash_out(out_proc)
        @OUT_PROC = out_proc
      end

      def process_with(klass)
        @PROCESSOR_KLASS = klass
      end

      def process!
        @IN_PROC.call
      end

      def process(item)
        convertor = @PROCESSOR_KLASS.new
        data = convertor.convert(item)
        @OUT_PROC.call(data)
      end
    end
  end
end
