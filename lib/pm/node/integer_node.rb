module Node
  class IntegerNode < Base
    TYPE = 'Integer'.freeze
    def initialize(val)
      @val = val.to_i
    end
  end
end
