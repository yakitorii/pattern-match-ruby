module Node
  class RegexpNode < Base
    TYPE = 'Regexp'.freeze

    def initialize(val = nil)
      @val = Regexp.new val.gsub(/^\//, '').gsub(/\/$/, '')
    end

    def match?(args, result: {})
      unless @val =~ args
        raise ValueNotMatchError.new(expected: @val, got: args)
      end
      result
    end
  end
end
