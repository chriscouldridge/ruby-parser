require 'strscan'

class Operator

  attr_accessor :operator_combination

  def initialize(operator_combination)

    @operator_combination = operator_combination

    @simplified_operators = []

    @is_valid = true

  end

  def evaluate

    num_multiply_operators = @operator_combination.count('*')

    num_division_operators = @operator_combination.count('/')

    num_add_operators = @operator_combination.count('+')

    num_subtract_operators = @operator_combination.count('-')

    puts "number of *: #{num_multiply_operators}"
    puts "number of /: #{num_division_operators}"
    puts "number of +: #{num_add_operators}"
    puts "number of -: #{num_subtract_operators}"

    if num_multiply_operators > 1
      @is_valid = false
      return 'Invalid operator combination'
    end

    if num_division_operators > 1
      @is_valid = false
      return 'Invalid operator combination'
    end

    @string_scanner = StringScanner.new(@operator_combination)

    @string_scanner.pos

    @is_end = 0

    while @is_end < 2

      pos_neg = @string_scanner.scan(/[\+|\-]{1,}/)

      puts pos_neg

      if pos_neg == nil then
        @is_end +=1
      else
        @simplified_operators << pos_neg
      end

      multiply_divide = @string_scanner.scan(/[\/|\*]{1,}/)

      puts multiply_divide

      if multiply_divide == nil then
        @is_end +=1
      else
        @simplified_operators << multiply_divide
      end

      puts "@simplified_operators: #{@simplified_operators}"

    end


    return ('+').downcase.to_sym

  end

end