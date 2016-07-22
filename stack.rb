class MyStack

  def initialize
    @stack = []
    @max = []
    @min = []
  end

  def pop
    @stack.pop
  end

  def push(item)
    @stack.push(item)
    @max << item if item >= @max
    @min << item if item <= @min
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

persons = [1,2,3]
class StackQueue

  def intitialize
    @stack1 = MyStack.new
    @stack2 = MyStack.new
  end

  def enqueue(el)
    until @stack1.empty?
      @stack2.push(@stack1.pop)
    end
    @stack1.push(el)
    until @stack2.empty?
      @stack1.push(@stack2.pop)
    end
  end

  def dequeue
    raise 'stack is empty' if @stack1.empty?
    @stack1.pop
  end



end
