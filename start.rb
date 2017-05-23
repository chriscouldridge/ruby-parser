require_relative 'ruby_parser_math'

my_ruby_parser = RubyParserMath.new()

my_ruby_parser.parse_file('ruby_files/simple_ruby_file.rb')

puts "\ntokens: #{my_ruby_parser.tokens}"

puts "\n@total: #{my_ruby_parser.total}"