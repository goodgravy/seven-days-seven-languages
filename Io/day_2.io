# 1. A Fibonacci sequence starts with two 1s. Each subsequent number is the sum of the two numbers that came before: 1, 1, 2, 3, 5, 8, 13, 21, and so on. Write a program to ﬁnd the nth Fibonacci number. ﬁb(1) is 1, and ﬁb(4) is 3. As a bonus, solve the problem with recursion and with loops.

fib := method(index, _fib(index, 1, 1))

_fib := method(iterations, lastVal, valBeforeLast,
  if(iterations <= 2,
    lastVal,
    _fib(iterations - 1, lastVal + valBeforeLast, lastVal)
  )
)

fibIter := method(index,
  if(index < 3,
    1,
    lastResult := 1
    result := 1
    (index - 2) repeat(
      tmp := result
      result = result + lastResult
      lastResult = tmp
    )
    result
  )
)

fib(1) println
fib(2) println
fib(3) println
fib(4) println
fib(5) println
fib(6) println
fib(7) println
fib(8) println

fibIter(1) println
fibIter(2) println
fibIter(3) println
fibIter(4) println
fibIter(5) println
fibIter(6) println
fibIter(7) println
fibIter(8) println

writeln("----------------------------------------------------------------------------")
# 2. How would you change / to return 0 if the denominator is zero?

Number origDivide := Number getSlot("/")
Number / = method(other,
  if(other == 0,
    0,
    self origDivide(other)
  )
)

writeln("----------------------------------------------------------------------------")
# 3. Write a program to add up all of the numbers in a two-dimensional array.

sum2dv1 := method(
  arrays,
  outerSum := 0
  arrays foreach(
    array,
    innerSum := 0
    array foreach(el, innerSum = innerSum + el)
    outerSum = outerSum + innerSum
  )
)

# Io> list(1, 2, 3) reduce(+)
# ==> 6
# Io> list(1, 2, 3) reduce(xs, x, xs + x)
# ==> 6
# Io> list(1, 2, 3) reduce(+, -6) // Passing the initial value.
# ==> 0
# Io> list(1, 2, 3) reduce(xs, x, xs + x, -6) ==> 0

sum2dv2 := method(
  arrays,
  arrays reduce(
    sum,
    array,
    sum + array reduce(+),
    0
  )
)

inputArrays := list(list(1, 2, 3), list(4, 5, 6), list(9))
writeln("sum2dv1 result (should be 30): " ..  sum2dv1(inputArrays))
writeln("sum2dv2 result (should be 30): " ..  sum2dv2(inputArrays))

writeln("----------------------------------------------------------------------------")
# 4. Add a slot called myAverage to a list that computes the average of all the numbers in a list. What happens if there are no numbers in a list? (Bonus: Raise an Io exception if any item in the list is not a number.)

List myAverage := method(
  sum := self reduce(
    accumulator,
    value,
    if(value type != "Number", Exception raise("#{value} is not a Number" interpolate))
    accumulator + value,
    0
  )
  sum / self size
)

list(1,2,3) myAverage println
list(1,2,4) myAverage println
list() myAverage println

writeln("----------------------------------------------------------------------------")
# 5. Write a prototype for a two-dimensional list. The dim(x, y) method should allocate a list of y lists that are x elements long. set(x, y , value) should set a value, and get(x, y) should return that value.

List2D := List clone

List2D asString = method(self _state asString)

List2D dim := method(x, y,
  # by using _state, we lose the usual List-y methods, e.g.
  # we can't do `List2D atPut` - how could we achieve that?
  self _state := Range 1 to(y) map(
    Range 1 to(x) map(nil)
  )
  self
)

List2D set := method(x, y, value,
  row := self _state at(y)
  row atPut(x, value)
)

List2D get := method(x, y,
  self _state at(y) at(x)
)

l := List2D clone
l dim(2, 3)
writeln("get before: " .. l get(1, 2))
l set(1, 2, "hi")
writeln("get after: " .. l get(1, 2))

writeln("----------------------------------------------------------------------------")
# 6. Bonus: Write a transpose method so that (new_matrix get(y, x)) == matrix get(x, y) on the original list.

List2D numRows := method(
  self _state size
)
List2D numCols := method(
  if(self numRows == 0, return 0)

  self _state first size
)

List2D transpose := method(
  if(self numRows == 0, return List2D clone)

  trans := List2D clone
  trans dim(self numRows, self numCols)

  self _state foreach(rowIndex, row,
    row foreach(columnIndex, value,
      trans set(rowIndex, columnIndex, value)
    )
  )
  trans
)

transL := l transpose

writeln("new_matrix get(2, 1) == matrix get(1, 2): #{transL get(2, 1)} == #{l get(1, 2)}" interpolate)

writeln("----------------------------------------------------------------------------")
# 7. Write the matrix to a ﬁle, and read a matrix from a ﬁle.

l set(0, 0, 1)
l set(0, 1, false)
l set(0, 2, "jimmy")
writeln("before writing to file: #{l}" interpolate)

List2D toFile := method(
  filename,
  f := File with(filename) remove openForAppending
  f write(self _state serialized) flush close
)

List2D fromFile := method(
  filename,
  f := File with(filename) openForReading
  doString(f contents)
)

outputFile := "output.bin"
l toFile(outputFile)
writeln("after reading from file: #{List2D fromFile(outputFile)}" interpolate)

writeln("----------------------------------------------------------------------------")
# 8. Write a program that gives you ten tries to guess a random number from 1–100. If you would like, give a hint of “hotter” or “colder” after the ﬁrst guess.

target := Random value(0, 100) floor
lastDelta := nil
10 repeat(
  write("What's your guess (0-100): ")
  guess := File standardInput readLine asNumber
  if(guess == target,
    "Correct!" println
    break
  )

  delta := (target - guess) abs
  if(lastDelta,
    if(delta < lastDelta, "Getting warmer… ", "Getting colder… ") print
  )
  lastDelta = delta
)
