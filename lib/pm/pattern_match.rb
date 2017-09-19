require_relative './pattern_lexicer.rb'
require_relative './node/base.rb'
require_relative './pattern_tree.rb'

class PatternMatch
  attr_reader :tree, :pattern_variables

  def self.save_binding(b)
    Thread.current[:pm_binding] = b
  end

  def initialize str
    tokens =  PatternLexicer.new(str).tokens
    p  tokens: tokens
    @tree = PatternTree.new(tokens: tokens, index: 0)
    @pattern_variables = @tree.variables
  end

  def =~(val)
    p node: @tree.node
    begin
      r = @tree.node.match?(val, result: {})
    rescue Node::PatternMatchError
      return nil
    end
    p result: r

    binding_obj = Thread.current[:pm_binding]
    r.each do |k,v|
      binding_obj.local_variable_set(k, v)
    end
    r
  end

  alias_method :===, :=~
end
