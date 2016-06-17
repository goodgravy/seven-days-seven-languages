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

# 5. Write a prototype for a two-dimensional list. The dim(x, y) method should allocate a list of y lists that are x elements long. set(x, y , v a l u e ) should set a value, and get(x, y) should return that value.
# 6. Bonus: Write a transpose method so that (new_matrix get(y, x)) == m a t r i x get(x, y) on the original list.
# 7. Write the matrix to a ﬁle, and read a matrix from a ﬁle.
# 8. Write a program that gives you ten tries to guess a random number from 1–100. If you would like, give a hint of “hotter” or “colder”
# after the ﬁrst guess.
