module Node
  class HashNode < Base
    TYPE = 'Hash'.freeze

    def match?(args, result: {})
      check_class(args)
      check_length(args)
      result = check_elements(args, result)
      result
    end

    def add_element(element)
      @val[element[:key]] = element[:val]
    end

    private

    def elements
      @val
    end

    def check_elements(args, result)
      args.each do |k, v|
        _element_k, element_v = search_element(k)
        if element_v
          result = element_v.match?(v, result: result)
        end
      end
      result
    end

    def search_element(arg_key)
      elements.find do |k, v|
        k.match? arg_key
        rescue PatternMatchError
          next
      end
    end
  end
end
