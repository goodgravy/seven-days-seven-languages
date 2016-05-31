# • For the string “Hello, Ruby,” ﬁnd the index of the word “Ruby.”

input = "Hello, Ruby,"
puts input.index "Ruby"

# • Print your name ten times.
10.times { puts 'Jimble' }

# • Print the string “This is sentence number 1,” where the number 1 changes from 1 to 10.
10.times { |n| puts "This is sentence number #{n + 1}," }

# • Run a Ruby program from a ﬁle.
# • Bonus problem: If you’re feeling the need for a little more, write a program that picks a random number. Let a player guess the number, telling the player whether the guess is too low or too high.

MAX = 100
target = rand(MAX)
print "Guess the number between 0 and #{MAX}: "
until (guess = gets.chomp.to_i) == target
  if guess > target
    print 'guess lower: '
  else
    print 'guess higher: '
  end
end
puts 'Correct!'
