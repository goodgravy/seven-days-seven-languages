# Enhance the XML program to add spaces to show the indentation structure.

Builder := Object clone
Builder depth := 0

Builder indent := method("  " repeated(depth))

Builder forward := method(
  writeln(indent, "<", call message name, ">")
  call message arguments foreach(
    arg,
    depth = depth + 1;
    content := self doMessage(arg);
    if(content type == "Sequence", writeln(indent, content))
    depth = depth - 1;
  )
  writeln(indent, "</", call message name, ">")
)

Builder  ul(
  li(strong("Io")),
  li("Lua"),
  li("JavaScript")
)

writeln("-------------------------------------------------")
# Create a list syntax that uses brackets.

squareBrackets := method(
  result := List clone;
  call message arguments foreach(argument, result append(argument))
  result
)

[1, false, "three"] println

writeln("-------------------------------------------------")
OperatorTable addAssignOperator(":", "atPutAttr")

curlyBrackets := method(
  r := Map clone
  call message arguments foreach(arg,
       r doMessage(arg)
       )
  r
)

Map atPutAttr := method(
  self atPut(
       call evalArgAt(0) asMutable removePrefix("\"") removeSuffix("\""),
       call evalArgAt(1))
)

BuilderWithAttrs := Object clone
BuilderWithAttrs depth := 0
BuilderWithAttrs withIncrementedDepth := method(
  depth = depth + 1;
  call evalArgs
  depth = depth - 1;
)

BuilderWithAttrs indent := method("  " repeated(depth))

BuilderWithAttrs forward := method(
  name := call message name
  args := call message arguments

  write(indent, "<", name)
  if(args at(0) name == "curlyBrackets",
    write(" ")
    attrs := doMessage(args at(0))
    attrs foreach(key, value, write("#{key}=\"#{value}\"" interpolate))
  )
  writeln(">")

  args foreach(
    arg,
    withIncrementedDepth (
      content := self doMessage(arg)
      if(content type == "Sequence", writeln(indent, content))
    )
  )
  writeln(indent, "</", call message name, ">")
)

# confusing to know this had to be separate from addAssignOperator
doFile("day_3_input.io")
