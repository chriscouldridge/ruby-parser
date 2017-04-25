require 'strscan'
require_relative 'Expression'
require_relative 'Token'
require_relative 'Operator'


class RubyParserMath

  attr_reader :tokens, :full_expression, :total


  def initialize

    @tokens = []

    @full_expression

    @is_expression = false

    @total

  end


  def parse_file(file_location)

    ruby_file_content = get_file_content(file_location)

    puts "ruby file content: #{ruby_file_content}"

    @string_scanner = create_string_scanner(ruby_file_content)

    @full_expression = parse_expression(@string_scanner)

    @total = (@is_expression ? (@full_expression).evaluate : ruby_file_content)

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


  def parse_expression(string_scanner)

    left_of_expression = parse_value(string_scanner)

    tokens << left_of_expression

    puts "@tokens: #{@tokens}"

    string_scanner.skip(/\s+/)

    operator = string_scanner.scan(/[\/|\*|\+|\-|\s]{1,}/)

    if operator

      @tokens << operator

      @is_expression = true

      operator_object = Operator.new(operator)

      Expression.new(operator_object, left_of_expression, parse_expression(string_scanner))

    else

      left_of_expression

    end

  end


  def parse_value(string_scanner)

    start = string_scanner.pos

    if string_scanner.skip(/\(/)

      parse_expression(string_scanner).tap do

        string_scanner.scan(/\)/) || raise('expression formed invalidly')

      end

    else

      parse_number(string_scanner)

    end

  end


  def parse_number(string_scanner)

    string_scanner.skip(/\s+/)

    string_scanner.scan(/[\d.]+/) || 'number expected'

  end

end

