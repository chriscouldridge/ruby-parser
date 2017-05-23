require 'test/unit'

require_relative '../ruby_parser_math'

class RubyParserMathParseValueTest < Test::Unit::TestCase

  def setup

    @test_ruby_parser = RubyParserMath.new()

  end

  def test_float

    @test_ruby_parser.string_scanner = StringScanner.new('5.0')

    response = @test_ruby_parser.parse_value()

    assert_equal('5.0', response)

  end

  def test_number

    @test_ruby_parser.string_scanner = StringScanner.new('5')

    response = @test_ruby_parser.parse_value()

    assert_equal('5', response)

  end

  def test_number_in_parentheses

    @test_ruby_parser.string_scanner = StringScanner.new('(5)')

    response = @test_ruby_parser.parse_value()

    assert_equal('(5)', response)

  end

  def test_expression_in_parentheses

    @test_ruby_parser.string_scanner = StringScanner.new('(5+3)')

    response = @test_ruby_parser.parse_value()

    puts "response: #{response}"

    assert_equal('(5+3)', response)

  end

  def test_no_closing_bracket

    @test_ruby_parser.string_scanner = StringScanner.new('(5')

    response = @test_ruby_parser.parse_value()

    assert_equal('expression formed invalidly', response)

  end

  def test_no_opening_bracket

    @test_ruby_parser.string_scanner = StringScanner.new(')')

    response = @test_ruby_parser.parse_value()

    assert_equal('expression formed invalidly', response)

  end

end