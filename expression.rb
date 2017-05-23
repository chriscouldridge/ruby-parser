class Expression

  attr_accessor :op, :left, :right

  def initialize(op, left, right)

    @op = op

    @left = left

    @right = right

  end

  def evaluate

    puts "\nExpression.evaluate"
    puts " left: #{@left}"
    puts " op: #{@op}"
    puts " right: #{@right}"

    left_value = (@left.class == Expression ? @left.evaluate : @left.to_f)

    right_value = (@right.class == Expression ? @right.evaluate : @right.to_f)

    operator_simple = @op.evaluate

    puts " left_value: #{left_value}, operator_simple:#{operator_simple}, right_value: #{right_value}"

    puts " left_value: #{left_value.class}, operator_simple:#{operator_simple.class}, right_value: #{right_value.class}"

    puts " evaluated as: #{left_value.send(operator_simple, right_value)}"

    left_value.send(operator_simple, right_value)

    end

end