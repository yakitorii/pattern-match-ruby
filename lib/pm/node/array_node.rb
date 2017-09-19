require_relative './base.rb'
module Node
  class ArrayNode < Base
    TYPE = 'Array'
    def match?(args, result: {})
      check_class(args)
      check_length(args)
      result = check_elements(args, result)
      result
    end

    def elements
      @val
    end

    def add_element(element)
      @val << element
    end

    def check_elements(args, result)
      args.each.with_index do |arg, i|
        result = elements[i].match?(arg, result: result)
      end
      result
    end
  end
end
