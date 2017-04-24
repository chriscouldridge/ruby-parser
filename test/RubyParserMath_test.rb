require 'test/unit'

require_relative '../ruby_parser_math'

class RubyParserMathTest < Test::Unit::TestCase

  def test_parse_number_with_alpha

    @string_scanner = StringScanner.new('not a number')

    test_ruby_parser = RubyParserMath.new()

    response = test_ruby_parser.parse_number(@string_scanner)

    assert_equal('number expected', response)

  end

  def test_parse_number_with_alphanumeric

    @string_scanner = StringScanner.new('four plus 12')

    test_ruby_parser = RubyParserMath.new()

    response = test_ruby_parser.parse_number(@string_scanner)

    assert_equal('number expected', response)

  end

  def test_parse_number_with_operators

    @string_scanner = StringScanner.new('++')

    test_ruby_parser = RubyParserMath.new()

    response = test_ruby_parser.parse_number(@string_scanner)

    assert_equal('number expected', response)

  end

  def test_parse_number_with_integer

    @string_scanner = StringScanner.new('125')

    test_ruby_parser = RubyParserMath.new()

    response = test_ruby_parser.parse_number(@string_scanner)

    assert_equal('125', response)

  end

  def test_parse_number_with_float

    @string_scanner = StringScanner.new('1.25')

    test_ruby_parser = RubyParserMath.new()

    response = test_ruby_parser.parse_number(@string_scanner)

    assert_equal('1.25', response)

  end

  def test_parse_number_with_negative_integer

    @string_scanner = StringScanner.new('-125')

    test_ruby_parser = RubyParserMath.new()

    response = test_ruby_parser.parse_number(@string_scanner)

    assert_equal('number expected', response)

  end

  def test_parse_number_with_leading_whitespace

    @string_scanner = StringScanner.new(' 4000')

    test_ruby_parser = RubyParserMath.new()

    response = test_ruby_parser.parse_number(@string_scanner)

    assert_equal('4000', response)

  end

  def test_parse_number_with_trailing_whitespace

    @string_scanner = StringScanner.new('4000 ')

    test_ruby_parser = RubyParserMath.new()

    response = test_ruby_parser.parse_number(@string_scanner)

    assert_equal('4000', response)

  end

end