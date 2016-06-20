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
