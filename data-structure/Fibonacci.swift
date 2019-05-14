import Foundation

struct Fibonacci: IteratorProtocol, Sequence {
    typealias Element = Int
    
    var state = (curr: 0, next: 1)
    
    mutating func next() -> Element? {
        let curr = state.curr
        state = (curr: state.next, next: state.curr + state.next)
        return curr
    }
}

var fibA = Fibonacci()

print(fibA.next())
print(fibA.next())
print(fibA.next())
print(fibA.next())
print(fibA.next())
print(fibA.next())
