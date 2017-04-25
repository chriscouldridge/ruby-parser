require 'strscan'

class Operator

  attr_accessor :operator_combination


  def initialize(operator_combination)

    @operator_combination = operator_combination

    @simplified_operators = []

    # @is_valid = true

  end


  def validate

    num_multiply_operators = @operator_combination.count('*')

    num_division_operators = @operator_combination.count('/')

    num_addition_operators = @operator_combination.count('+')

    num_subtract_operators = @operator_combination.count('-')

    puts "number of *: #{num_multiply_operators}, number of /: #{num_division_operators}, number of +: #{num_addition_operators}, number of -: #{num_subtract_operators}"

    if num_multiply_operators > 1 || num_division_operators > 1

      # @is_valid = false

      # 'Invalid operator combination'

      false

    end

    true

  end


  def evaluate_positive_negative

    pos_neg = @string_scanner.scan(/[\+|\-|\s]{1,}/)

    unless pos_neg != nil

      return 'No pos neg'

    end

    count_negative = pos_neg.scan(/-/).count

    # puts "pos_neg: #{pos_neg}, - count_negative: #{count_negative}"

    if count_negative % 2 == 1

      return ('-').downcase.to_sym

      else

        return ('+').downcase.to_sym

      end

  end


  def evaluate

    unless validate

      return 'Invalid operator combination'

    end

    puts "operator combination: #{@operator_combination}"

    @string_scanner = StringScanner.new(@operator_combination)

    @string_scanner.pos

    @is_end = 0

    return evaluate_positive_negative

    # while @is_end < 2

      # pos_neg = @string_scanner.scan(/[\+|\-]{1,}/)

      # puts pos_neg

      # if pos_neg == nil then

        # @is_end += 1

      # else

        # @simplified_operators << pos_neg

      # end

      # multiply_divide = @string_scanner.scan(/[\/|\*]{1,}/)

      # puts multiply_divide

      # if multiply_divide == nil then

        # @is_end += 1

      # else

        # @simplified_operators << multiply_divide

      # end

      # puts "@simplified_operators: #{@simplified_operators}"

    # end


    # return ('+').downcase.to_sym

  end

end