require_relative 'stack.rb'

def my_min(array)
  array.each do |el|
    return el if array.all? { |jel| jel >= el }
  end
end




def my_min_min(array)
  min = array.first
  array[1..-1].each do |el|
    min = el if el < min
  end
  min
end

#p my_min_min([ 0, 3, 5, 4, -5, 10, 1, 90 ])
list = [5, 3, -7]
list2 = [2, 3, -6, 7, -6, 7]
list3 = [1,3,2,4,5,6,7,8,5,3,2,43,5,6,7].shuffle
list4 = [-6,-2,-5,-4,-1]
def largest_contiguous_subsum(list)
  array = []

  (0...list.length).each do |i|
    (i...list.length).each do |j|
      sub_array = list[i..j]
      array << sub_array unless array.include?(sub_array)
    end
  end

  array.map { |el| el.reduce(:+) }.max
end


require 'byebug'
def largest_contiguous_subsum_linear(list)
  #byebug
  largest = list.first
  tally = list.first
  list[1..-1].each do |el|
    if el >= 0
      tally += el
      largest = tally if tally > largest
    else
      tally += el
      largest = tally if tally > largest
      tally < 0 ? tally = 0 : tally = tally
    end
  end
  largest

end

# p largest_contiguous_subsum_linear(list)
# p largest_contiguous_subsum_linear(list4)


def first_anagram?(word1, word2)
  word1.chars.permutation.include?(word2.chars)
end
# p first_anagram?("gizmo", "sally")
# p first_anagram?("elvis", "lives")
# random_string = "ldshfgkjdlhdshgkjdshfgjkdshfgkldshgfldhgflkdhsfgldhsfgjkldfghkldghlkdsfghkldsfghkldsfghkldfsghkldfghkldfghkldshfgklgfhklhfkdlsfgldks;fghjlkdfsgdfslkghjdfglhkdf"
# string2 = random_string.chars.shuffle.join
# p first_anagram?(random_string, string2)


def second_anagram?(word1, word2)
  return false unless word1.length == word2.length
  word1.chars.each do |char|
    if word2.chars.include?(char)
      word1.delete!(char)
      word2.delete!(char)
    end
  end
  return true if word1.empty? && word2.empty?
  false
end


def third_anagram?(word1, word2)
  word1.chars.sort == word2.chars.sort
end

# p third_anagram?("gizmo", "sally")
# p third_anagram?("lvise", "lives")

def fourth_anagram?(word1, word2)
  return false unless word1.length == word2.length
  hash1 = Hash.new(0)
  hash2 = Hash.new(0)
  (0...word1.length).each do |i|
    hash1[word1[i]] += 1
    hash2[word2[i]] += 1
  end
  hash1 == hash2
end

# p fourth_anagram?("gizmo", "sally")
# p fourth_anagram?("lvise", "lives")

def fifth_anagram?(word1, word2)
  return false unless word1.length == word2.length
  hash = Hash.new(0)
  (0...word1.length).each do |i|
    hash[word1[i]] += 1
    hash[word2[i]] -= 1
  end
  p hash.values.join
  hash.values.all?{|el| el == 0}
end

# p fifth_anagram?("gizmo", "sally")
# p fifth_anagram?("lvisee", "livese")

#n^2 complexity for brute force solution
def bad_two_sum?(array, target)
  (0...array.length).each do |i|
    (i+1...array.length).each do |j|
      return true if array[i] + array[j] == target
    end
  end
  false
end

#nlgn
def okay_two_sum?(array, target)
  sorted = array.sort
  i = 0
  j = sorted.length - 1
  until j <= i
    sum = sorted[i] + sorted[j]
    return true if sum == target
    if sum > target
      j -= 1
    else
      i += 1
    end
  end
  false
end

def bsearch(array, target)
  mid = array.length / 2
  return mid if array[mid] == target

  if array[mid] > target
    bsearch(array[0...mid], target)
  else
    return mid + bsearch(array[(mid)..-1], target)
  end
  return nil
end

arr = [0, 1, 5, 7]
# p okay_two_sum?(arr, 6) # => should be true
# p okay_two_sum?(arr, 10) # => should be false

def pair_sum?(array, target)
  hash = Hash.new(0)
  array.each{|el| hash[el] += el}
  until hash.empty?
    i = hash.keys.max
    diff = (i - target).abs
    hash.delete(i)
    return true if hash.has_key?(diff)
  end
  false
end

# p pair_sum?(arr, 6) # => should be true
# p pair_sum?(arr, 10) # => should be false

def four_sum?(array, target)
  fours = array.combination(4).to_a
  fours.map!{|el| el.reduce(:+)}
  fours.any?{|el| el == target}
end

# p four_sum?([1,2,3,4,5,6,7,8,9], 23)


def windowed_max_range(array, w)
  result = StackQueue.new
  (array.length - (w-1)).times do |i|
    slice = StackQueue.new
    intermediate_arr = array.slice(i,w)
    #p intermediate_arr
    intermediate_arr.each do |el|
      #p "enqueing #{el}"
      slice.enqueue(el)
    end
    range = (slice.max - slice.min)
    #p "#{slice.max} - #{slice.min} = #{range}"
    result.enqueue(range)
  end
  p result.max
end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
