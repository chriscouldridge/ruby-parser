require 'test/unit'

require_relative '../ruby_parser_math'

class RubyParserMathParseNumberTest < Test::Unit::TestCase

  def setup

    @test_ruby_parser = RubyParserMath.new()

  end

  def test_alphabetic_string

    @test_ruby_parser.string_scanner = StringScanner.new('not a number')

    response = @test_ruby_parser.parse_number()

    assert_equal('number expected', response)

  end

  def test_alphanumeric_string

    @test_ruby_parser.string_scanner = StringScanner.new('four plus 12')

    response = @test_ruby_parser.parse_number()

    assert_equal('number expected', response)

  end

  def test_operators

    @test_ruby_parser.string_scanner = StringScanner.new('++')

    response = @test_ruby_parser.parse_number()

    assert_equal('number expected', response)

  end

  def test_integer

    @test_ruby_parser.string_scanner = StringScanner.new('125')

    response = @test_ruby_parser.parse_number()

    assert_equal('125', response)

  end

  def test_float_to_two_decimal_places

    @test_ruby_parser.string_scanner = StringScanner.new('1.25')

    response = @test_ruby_parser.parse_number()

    assert_equal('1.25', response)

  end

  def test_negative_integer

    @test_ruby_parser.string_scanner = StringScanner.new('-125')

    response = @test_ruby_parser.parse_number()

    assert_equal('number expected', response)

  end

  def test_leading_whitespace

    @test_ruby_parser.string_scanner = StringScanner.new(' 4000')

    response = @test_ruby_parser.parse_number()

    assert_equal('4000', response)

  end

  def test_trailing_whitespace

    @test_ruby_parser.string_scanner = StringScanner.new('4000 ')

    response = @test_ruby_parser.parse_number()

    assert_equal('4000', response)

  end

  def teardown

    @test_ruby_parser = nil

  end

end