public class LinkedListSet<Element: Equatable>: Set {
    
    private var list = LinkedList<Element>()
    
    public init() {
        print("initial with nothing")
    }
    
    public init(_ value: Element) {
        list.push(value)
        print("initial with value: \(value)")
    }
    
    public init(_ array:[Element]) {
        for item in array {
            if !list.contains(item) {
                list.push(item)
            }
        }
        print("initial with array: \(list)")
    }
    
    public var size: Int {
        return list.size
    }
    
    public var isEmpty: Bool {
        return list.isEmpty
    }
    
    public func add(_ element: Element) {
        if !list.contains(element) {
            list.push(element)
        }
    }
    
    public func remove(_ element: Element) {
        list.remove(element)
    }
    
    public func contains(_ element: Element) -> Bool {
        return list.contains(element)
    }
}
