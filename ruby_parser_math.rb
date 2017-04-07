require 'strscan'
require_relative 'Expression'
require_relative 'Token'
require_relative 'Operator'


class RubyParserMath

  attr_reader :tokens



  #class Expression < Struct.new(:op, :left, :right)
  #end

  def initialize(str_file_location)

    @tokens =[]

    ruby_file = File.new(str_file_location)

    ruby_file_content = ruby_file.read

    puts "ruby file content: #{ruby_file_content}"

    @string_scanner = StringScanner.new(ruby_file_content)

    @string_scanner.pos

    @full_expression

    @is_expression = false

    @full_expression = parse_expression(@string_scanner)

    puts "tokens: #{@tokens.join(', ')}"

    puts "full expression: #{@full_expression}"

    if @is_expression

      puts @full_expression.class

      #puts "total = #{evaluate(@full_expression)}"

      puts "total = #{(@full_expression).evaluate}"
    else
      puts "total = #{ruby_file_content}"
    end

  end

  def parse_expression(string_scanner)

    puts 'parsing expression'

    left_of_expression = parse_value(string_scanner)
    puts "left_of_expression: #{left_of_expression}"
    @tokens << left_of_expression
    puts "tokens: #{@tokens.join(', ')}"

    string_scanner.skip(/\s+/)

    operator = string_scanner.scan(/[\/|\*|\+|\-]{1,}/)

    puts "operator: #{operator}"

    if operator

      @tokens << operator

      @is_expression = true

      puts "tokens: #{@tokens.join(', ')}"

      operator_object = Operator.new(operator)

      #Expression.new(operator.downcase.to_sym, left_of_expression, parse_expression(string_scanner))
      Expression.new(operator_object, left_of_expression, parse_expression(string_scanner))

    else
      left_of_expression
    end

  end


  def parse_value(string_scanner)

    puts 'parsing value'
    start = string_scanner.pos

    if string_scanner.skip(/\(/)

      parse_expression(string_scanner).tap do

        string_scanner.scan(/\)/) or

            raise 'expression formed invalidly'

      end

    else

      parse_number(string_scanner)

    end

  end


  def parse_number(string_scanner)
    puts "parsing number at position #{string_scanner.pos}"

    string_scanner.scan(/\d+/) ||
        raise('number expected')

  end

  def parse_term(string_scanner)
    puts 'parsing term'
    string_scanner.skip(/\s+/)

    value = parse_value(string_scanner)

    return value if value is_a?(Expression)

  end




end

