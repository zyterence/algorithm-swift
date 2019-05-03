struct Stack<Element> {

   private var storage: [Element] = []

   public init(_ elements: [Element]) {
       storage = elements
   }

   public mutating func push(_ element: Element) {
       storage.append(element)
   }

   @discardableResult
   public mutating func pop() -> Element? {
       return storage.popLast()
   }

   func peek() -> Element? {
       return storage.last
   }

   public var isEmpty: Bool {
       return peek() == nil
   }
}