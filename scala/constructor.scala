class Person(firstName: String) {
  println("Outer constructor")
  def this(firstName: String, lastName: String) {
    this((() => {
      println("Inner constructor")
      firstName + lastName
    })())
  }
  def talk() = println("Hi")
}
val bob = new Person("Bob")
val bobTate = new Person("Bob", "Tate")

def doTheThing(firstName: String, lastName: String) {
  println("Inner constructor")
  firstName + lastName
}
