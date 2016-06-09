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

if(0, "0 is true", "0 is false") println
if("", "\"\" is true", "\"\" is false") println
if(nil, "nil is true", "nil is false") println

Car proto slotNames println

fiesta := Car clone
fiesta slotNames println
fiesta colour ::= "red"
fiesta slotNames println

fiesta start := method("cough cough splutter" println)
fiesta start

MyObject := Object clone
MyObject boof := method(
  "I'VE BEEN CALLED" println
)

MyObject pleaseCall := method(
  self perform(doMessage(call message argAt(0)))
)
MyObject pleaseCall2 := method(
  name,
  self perform(name)
)
MyObject pleaseCall("boof")
MyObject pleaseCall2("boof")
