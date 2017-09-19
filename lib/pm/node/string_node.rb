module Node
  class StringNode < Base
    TYPE = 'String'.freeze
    def initialize(val)
      @val = val.gsub(/^('|")/, '').gsub(/('|")$/, '')
    end

    def match?(args, result: {})
      check_class(args)
      unless @val == args
        raise ValueNotMatchError.new(expected: @val, got: args)
      end
      result
    end
  end
end
