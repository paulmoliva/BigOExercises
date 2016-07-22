require 'byebug'
require_relative 'my_stack.rb'


persons = [1,2,3]
class StackQueue
  attr_reader :stack1
  def initialize
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

  def max
    @stack1.max
  end

  def min
    @stack1.min
  end

  def empty?
    @stack1.empty?
  end


end
