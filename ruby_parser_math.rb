require 'strscan'
require_relative 'Token'

class RubyParserMath

  attr_reader :tokens



  class Expression < Struct.new(:op, :left, :right)
  end

  def initialize(str_file_location)

    @tokens =[]

    ruby_file = File.new(str_file_location)
    ruby_file_content = ruby_file.read
    puts ruby_file_content

    @string_scanner = StringScanner.new(ruby_file_content)
    @string_scanner.pos
    @full_expression
    @is_expression = false

    @full_expression = parse_expression(@string_scanner)

    puts "tokens: #{@tokens.join(', ')}"
    puts "full expression: #{@full_expression}"

    if @is_expression
      puts "total = #{evaluate(@full_expression)}"
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

    operator = string_scanner.scan(/\*|\+|\-)
    puts operator

    if operator
      @tokens << operator
      @is_expression = true
      puts "tokens: #{@tokens.join(', ')}"
      Expression.new(operator.downcase.to_sym, left_of_expression, parse_expression(string_scanner))

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


  def evaluate(expression)
    puts "evaluating expression: left is: #{expression['left'].class}, right is: #{expression['right'].class}, operator is #{expression['op']}"

    if expression['left'].class == Expression

      left_value = evaluate(expression['left'])
      puts "left_value: #{left_value}"

    else

      left_value = expression['left'].to_i
      puts "left_value: #{left_value}"

    end

    if expression['right'].class == Expression

      right_value = evaluate(expression['right'])
      puts "right_value: #{right_value}"

    else

      right_value = expression['right'].to_i
      puts "right_value: #{right_value}"

    end

    case expression['op'].to_s
      when '+'
        return (left_value + right_value)
      when '-'
        return (left_value - right_value)
      when '*'
        return (left_value * right_value)
      when '/'
        return (left_value / right_value)
      else
        return 'error'
    end



  end










  def parse_term(string_scanner)
    puts 'parsing term'
    string_scanner.skip(/\s+/)

    value = parse_value(string_scanner)

    return value if value is_a?(Expression)

  end




end

