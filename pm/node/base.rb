module Node
  class PatternMatchError < StandardError
    def initialize(expected:, got:)
      message = "expected value is #{expected} but got #{got}"
      super(message)
    end
  end

  class ClassNotMatchError  < PatternMatchError; end
  class LengthNotMatchError < PatternMatchError; end
  class ValueNotMatchError  < PatternMatchError; end

  class Base
    attr_reader :val
    def initialize(val = nil)
      @val = val
    end

    def match?(args, result: {})
      check_class(args)
      unless @val == args
        raise ValueNotMatchError.new(expected: @val, got: args)
      end
      result
    end

    def check_class(args)
      expected = self.class::TYPE
      got  =  args.class.to_s
      expected  == got || raise(ClassNotMatchError.new(expected: expected, got: got))
    end

    def check_length(args)
      expected = args.length
      got = elements.length
      expected  == got || raise(LengthNotMatchError.new(expected: expected, got: got))
    end
  end
end
