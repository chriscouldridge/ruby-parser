#class Expression < Struct.new(:op, :left, :right) do
class Expression

  attr_accessor :op, :left, :right

  def initialize(op, left, right)
    puts "new Expression (#{left}, #{op}, #{right})"
    @op = op
    @left = left
    @right = right

  end

  def evaluate

    puts "evaluating :right.class = #{@right.class} :left.class = #{@left.class}"

    if @left.class == Expression

      left_value = @left.evaluate

    else

      left_value = @left.to_f

    end

    if @right.class == Expression

      right_value = @right.evaluate

    else

     right_value = @right.to_f

    end

    operator_simple = @op.evaluate

    puts "left_value: #{left_value}, operator_simple:#{operator_simple}, right_value: #{right_value}"

    left_value.send(operator_simple, right_value)

    end

end