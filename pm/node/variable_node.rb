module Node
  class VariableNode < Base
    TYPE = :varable

    def match?(args, result: {})
      return result if @val == '_'
      result.merge({ @val.to_s => args })
    end
  end
end
