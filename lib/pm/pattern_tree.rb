Dir[ "#{File.dirname(__FILE__)}/node/*.rb"].each do |file|
  require file
end

class PatternTree
  class InvalidPatternError < StandardError; end
  attr_reader :node, :variables
  def initialize(tokens:, index:)
    @tokens = tokens
    @variables = []
    @index = index
    @tree = nil
    @node = read_token
  end

  def read_token
    p read_toke_tye: current_token.type if $VERBOSE
    case current_token.type
      when PatternLexicer::END_TOKEN_TYPE
        raise
      when :integer
        read_iteger
      when :symbol
        read_symbol
      when :string
        read_string
      when :array_st
        read_array
      when :hash_st
        read_hash
      when :variable
        read_variable
      when :class_name
        read_class_name
      when :regexp
        read_regexp
      when :comma
      when :array_end
      when :hash_end
      else
    end
  end

  def read_iteger
    node = Node::IntegerNode.new(current_token.val)
    @index += 1
    node
  end

  def read_symbol
    node = Node::SymbolNode.new(current_token.val)
    @index += 1
    node
  end

  def read_string
    node = Node::StringNode.new(current_token.val)
    @index += 1
    node
  end

  def read_regexp
    node = Node::RegexpNode.new(current_token.val)
    @index += 1
    node
  end

  def read_array
    array_node = Node::ArrayNode.new([])
    @index += 1
    token = @tokens[@index]

    raise InvalidPattarray_endernError.new("Tokens: #{@tokens} is invalid") if abnormal_token_types.include? token.type

    while current_token.type != :array_end
      if current_token.type == :comma
        @index += 1
        next
      end
      element = read_token
      p array_el: element if $VERBOSE
      array_node.add_element element
    end

    @index += 1
    array_node
  end

  def read_hash
    hash_node = Node::HashNode.new({})
    element = { key: nil, val: nil }
    @index += 1

    while current_token.type != :hash_end
      if current_token.type == :hash_delimiter
        @index += 1
        next
      end

      if current_token.type == :comma
        @index += 1
        element = { key: nil, val: nil }
        next
      end

      element_part = read_token

      if element[:key].nil?
        element[:key] = element_part
      else
        element[:val] = element_part
        hash_node.add_element element
      end
    end

    @index += 1
    hash_node
  end

  def read_variable
    val = current_token.val
    @index += 1
    @variables << val
    Node::VariableNode.new(val)
  end

  def read_class_name
    node = Node::ClassNameNode.new(current_token.val)
    @index += 1
    node
  end

  def current_token
    @tokens[@index]
  end

  def abnormal_token_types
    if @next_can_delimiter
      [PatternLexicer::END_TOKEN_TYPE, :comma]
    else
      [PatternLexicer::END_TOKEN_TYPE]
    end
  end
end
