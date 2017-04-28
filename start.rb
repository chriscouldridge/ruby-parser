require_relative 'ruby_parser_math'

my_ruby_parser = RubyParserMath.new()

my_ruby_parser.parse_file('ruby_files/simple_ruby_file.rb')

puts "tokens: #{my_ruby_parser.tokens}"

puts my_ruby_parser.total