# Print the contents of an array of sixteen numbers, four numbers at a time, using just each. Now, do the same with each_slice in Enumerable.

input = 1..16
buffer = []

input.each do |n|
  buffer << n
  if buffer.size == 4
    puts buffer.join(', ')
    buffer = []
  end
end

input.each_slice(4) { |slice| puts slice.join(', ') }

# The Tree class was interesting, but it did not allow you to specify a new tree with a clean user interface. Let the initializer accept a nested structure with hashes and arrays. You should be able to specify a tree like this: {’grandpa’ => { ’ d a d ’ => {’child 1’ => {}, ’child 2’ => {} }, ’uncle’ => {’child 3’ => {}, ’child 4’ => {} } } }.

class Tree
  def initialize(children, label = nil)
    @children = []
    @label = label
    children.each do |child_label, child|
      @children << Tree.new(child, child_label)
    end
  end

  def visit_all(&block)
    visit(&block)
    @children.each { |child| child.visit_all(&block) }
  end

  def to_s
    "#{@label}: #{@children.map(&:to_s)}"
  end

  private

  def visit(&block)
    block.call self
  end
end

puts Tree.new('grandpa' => { 'dad' => {'child 1' => {}, 'child 2' => {} }, 'uncle' => {'child 3' => {}, 'child 4' => {} } })

# Write a simple grep that will print the lines of a file having any occurrences of a phrase anywhere in that line. You will need to do a simple regular expression match and read lines from a file. (This is surprisingly simple in Ruby.) If you want, include line numbers.

def grep(filename, needle)
  File.open(filename).each_with_index do |line, line_number|
    puts "#{line_number + 1}: #{line}" if line.include? needle
  end
end

grep __FILE__, 'children'
