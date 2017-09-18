module Node
  class ClassNameNode < Base
    TYPE = 'ClassName'.freeze
    def initialize(val)
      @val = val.gsub(/^_/, '')
    end

    def match?(args, result: {})
      args.class.name == @val || raise(ClassNotMatchError.new(expected: @val, got: args))
      result
    end
  end
end
