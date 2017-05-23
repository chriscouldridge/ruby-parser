require 'test/unit'

require_relative '../ruby_parser_math'

class RubyParserMathParseOperatorTest < Test::Unit::TestCase

  def setup

    @test_ruby_parser = RubyParserMath.new()

  end

  def test_simple_negative

    @test_ruby_parser.string_scanner = StringScanner.new('-')

    response = @test_ruby_parser.parse_operator()

    assert_equal('-', response)

  end

  def test_simple_positive

    @test_ruby_parser.string_scanner = StringScanner.new('+')

    response = @test_ruby_parser.parse_operator()

    assert_equal('+', response)

  end

  def test_simple_multiply

    @test_ruby_parser.string_scanner = StringScanner.new('*')

    response = @test_ruby_parser.parse_operator()

    assert_equal('*', response)

  end

  def test_simple_divide

    @test_ruby_parser.string_scanner = StringScanner.new('/')

    response = @test_ruby_parser.parse_operator()

    assert_equal('/', response)

  end

  def test_leading_whitespace

    @test_ruby_parser.string_scanner = StringScanner.new(' +')

    response = @test_ruby_parser.parse_operator()

    assert_equal('+', response)

  end

  def test_trailing_whitespace

    @test_ruby_parser.string_scanner = StringScanner.new('+ ')

    response = @test_ruby_parser.parse_operator()

    assert_equal('+', response)

  end

  def test_compound_addition_multiplication

    @test_ruby_parser.string_scanner = StringScanner.new('+-')

    response = @test_ruby_parser.parse_operator()

    assert_equal('+-', response)

  end

  def test_single_enclosed_whitespace

    @test_ruby_parser.string_scanner = StringScanner.new('+ -')

    response = @test_ruby_parser.parse_operator()

    assert_equal('+ -', response)

  end

  def test_double_enclosed_whitespace

    @test_ruby_parser.string_scanner = StringScanner.new('+  +')

    response = @test_ruby_parser.parse_operator()

    assert_equal('+  +', response)

  end

  def test_alphabetic_string

    @test_ruby_parser.string_scanner = StringScanner.new('not a number')

    response = @test_ruby_parser.parse_operator()

    assert_equal('operator expected', response)

  end

  def test_alphanumeric_string

    @test_ruby_parser.string_scanner = StringScanner.new('four plus 12')

    response = @test_ruby_parser.parse_operator()

    assert_equal('operator expected', response)

  end

  def teardown

    @test_ruby_parser = nil

  end

end