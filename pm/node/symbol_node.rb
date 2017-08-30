module Node
  class SymbolNode < Base
    TYPE = 'Symbol'.freeze

    def initialize(val)
      @val = val.gsub(':', '').to_sym
    end
  end
end
