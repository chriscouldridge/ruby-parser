class Token
  attr_reader :name
  attr_accessor :content

  def initialize(name)
    @name = name
  end
end