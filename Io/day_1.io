# No compile-time warning or error: dynamically-typed
var := 1
var = "one"
var println

# No compile-time warning or error: weakly-typed
Car := Object clone
House := Object clone
whereILive := House clone

"Prototype before:" println
whereILive proto println

whereILive proto = Car
"Prototype after:" println
whereILive proto println
