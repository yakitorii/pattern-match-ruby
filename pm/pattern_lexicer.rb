require 'strscan'
class PatternLexicer
  attr_reader :tokens
  END_TOKEN_TYPE = :end

  VARIABLE_REGEXPS = /[a-z_][a-z0-9_]*/

  START_OPERATERS = {
    /\[/      => { type: :array_st },
    /\{/  => { type: :hash_st },
  }.freeze


  LITERALS = {
    /_[A-Z][a-z0-9]*/   => { type: :class_name },
    /\d+/               => { type: :integer },
    /'.*'/              => { type: :string },
    /".*"/              => { type: :string },
    /:[a-z][a-z0-9]*/   => { type: :symbol },
    /:'.*'/             => { type: :symbol },
    /:".*"/             => { type: :symbol },
    /[a-z][a-z0-9]*:/   => { type: :hash_symbol_key },
    VARIABLE_REGEXPS    => { type: :variable },
    /\/.*\//            => { type: :regexp },
  }.freeze

  DELIMITERS = {
    /,/  => { type: :comma },
    /=>/ => { type: :hash_delimiter },
  }.freeze

  END_OPERATERS = {
    /\]/  => { type: :array_end },
    /\}/  => { type: :hash_end },
  }.freeze

  ALL_TOKEN_PATTERNS  = START_OPERATERS.merge(LITERALS).merge(DELIMITERS).merge(END_OPERATERS)

  def initialize str
    p pattern_str_lexier: str
    @pattern_str = str
    @scanner = StringScanner.new(@pattern_str)
    @tokens = (scan_tokens) + [Token.new(val: nil, type: END_TOKEN_TYPE)]
  end

  def scan_tokens
    tokens = []
    return tokens if @scanner.eos?

    while !@scanner.eos?
      @scanner.scan(/\s/)
      pattern_data =  ALL_TOKEN_PATTERNS.detect do |pattern, data|
        str_val = @scanner.scan(pattern)

        if str_val
          tokens_data = ALL_TOKEN_PATTERNS[pattern]
          type = tokens_data[:type]
          token = Token.new(val: str_val, type: type)
          tokens << token
          true
        else
          false
        end
      end

      unless pattern_data
        raise @scanner.string[@scanner.pos..-1].inspect
      end
    end
    tokens
  end

  class Token
    attr_reader :val, :type
    def initialize(val: val, type: type)
      if type == :hash_symbol_key
        val = ":#{val.gsub(/:$/,  '')}"
        type = :symbol
      end

      @val = val
      @type = type
    end
  end
end
