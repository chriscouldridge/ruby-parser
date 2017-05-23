require 'strscan'
require_relative 'Expression'
require_relative 'Token'
require_relative 'Operator'


class RubyParserMath

  attr_reader :tokens, :full_expression, :total

  attr_writer :string_scanner


  def initialize

    @tokens = []

    @unprocessed_tokens = []

    @full_expression

    @total

    @string_scanner

  end


  def parse_file(file_location)

    ruby_file_content = get_file_content(file_location)

    puts "ruby file content: #{ruby_file_content}"

    @string_scanner = create_string_scanner(ruby_file_content)

    tokenise_string

    @unprocessed_tokens = @tokens.clone

    make_nested_expressions_from_tokens

  end

  def get_file_content(file_location)

    ruby_file = File.new(file_location)

    ruby_file.read

  end


  def create_string_scanner(content_string)

    string_scanner = StringScanner.new(content_string)

    string_scanner.pos

    string_scanner

  end

  def tokenise_string

    puts 'tokenise_string'

    if @string_scanner.rest?

      this_number = parse_number

      puts " this_number: #{this_number}"

      if this_number == 'number expected' || this_number ==''

        this_operator = parse_operator

        if this_operator == 'operator expected' || this_operator == ''

          this_value = parse_value

          if this_value == 'expression formed invalidly'

            raise this_value

          else

            tokens << this_value

          end

        else

          this_operator_hash = {:type => 'operator', :value => this_operator}

          tokens << this_operator_hash

          end

      else

        this_number_hash = {:type => 'number', :value => this_number}

        tokens << this_number_hash

      end

      tokenise_string

    else

      'finished'

    end

  end



  def make_nested_expressions_from_tokens()

    puts 'make_nested_expressions_from_tokens'

    first_number_position = @unprocessed_tokens.index { |x| x[:type] == 'number'}

    first_number = ''

    i = 0

    max = first_number_position

    puts " first_number_position: #{first_number_position}"

    while i <= first_number_position do

      puts "number: #{@tokens[i]['value']}"

      first_number += (@tokens[i][:value])

      puts " first_number: #{first_number}"

      i +=1

    end

    @unprocessed_tokens.shift(first_number_position + 1)

    @full_expression = nest_expression(first_number)

    puts @full_expression

    evaluate_expression(@full_expression)

  end



  def nest_expression(left_of_expression)

    puts "nest_expression(#{left_of_expression}, #{@unprocessed_tokens})"

    operator_position = @unprocessed_tokens.index{ |x| x[:type] == 'operator'}

    puts " next operator position: #{operator_position}"

    next_operator = @unprocessed_tokens.detect { |x| x[:type] == 'operator'}

    puts " next operator: #{next_operator}"

    next_operator_object = Operator.new(next_operator[:value])

    nested_expression = Expression.new(next_operator_object, left_of_expression, @unprocessed_tokens[operator_position + 1][:value])

    @unprocessed_tokens.shift(operator_position + 2)

    if @unprocessed_tokens.length > 0 then

    nest_expression(nested_expression)

    else

      nested_expression

    end

  end

  def evaluate_expression(expression)

    puts "\nevaluate_expression"

    @total = expression.evaluate

  end


  def parse_expression

    puts 'parse expression'

    left_of_expression = parse_value()

    tokens << left_of_expression

    puts "@tokens: #{@tokens}"

    @string_scanner.skip(/\s+/)

    operator = @string_scanner.scan(/[\/|\*|\+|\-|\s]{1,}/)

    if operator

      @tokens << operator.strip!

      @is_expression = true

      operator_object = Operator.new(operator)

      right_of_expression = parse_value()

      #Expression.new(operator_object, left_of_expression, parse_expression())

    else

      left_of_expression

    end

  end


  def parse_value

    puts 'parse value'

    # change this so that it just adds tokens to the array without any parenthesis matching logic
    # the only logic should be that it checks that there are the correct number of matching parentheses in the rest of the string

    @string_scanner.skip(/\s+/)

    puts "parse_value: peek #{@string_scanner.peek(1)}"

    if @string_scanner.peek(1) == '('

      pattern = /[\(][\d]*[\.]?[\d]*[\+|\-|\s]*[\d]+[\)]/

      value_string = @string_scanner.scan(pattern) || 'expression formed invalidly'

      subtokens = ['(']

      return '3'

    elsif @string_scanner.peek(1) == ')'

      'expression formed invalidly'

    else

      parse_number()

    end

  end


  def parse_number

    @string_scanner.skip(/\s+/)

    @string_scanner.scan(/([\d]*[\.]?[\d]+)/) || 'number expected'

  end

  def parse_operator

    @string_scanner.skip(/\s+/)

    @string_scanner.scan(/[\+|\-|\s]+/) || 'operator expected'

  end

end

