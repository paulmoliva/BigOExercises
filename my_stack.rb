class MyStack
  attr_reader :stack
  def initialize
    @stack = []
    @max = []
    @min = []
  end

  def pop
    if @stack.last == @max.last
      @max.pop
    elsif @stack.last == @min.last
      @min.pop
    end
    @stack.pop
  end

  def push(item)
    @stack.push(item)
    @max << item if item >= max
    @min << item if item <= min
  end

  def max
    @max.last || 0
  end

  def min
    @min.last || 999999999999999
  end

  def peek
    @stack.last
  end

  def size
    @stack.length
  end

  def empty?
    @stack.empty?
  end
end
