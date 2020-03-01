public struct Queue<Element> {

    private var storage: [Element] = []

    public init() {}
    
    public var isEmpty: Bool {
        return storage.isEmpty
    }
    
    public var peek: Element? {
        return storage.first
    }
    
    @discardableResult
    public mutating func enqueue(_ element: Element) -> Bool {
        storage.append(element)
        return true
    }
    
    @discardableResult
    public mutating func dequeue() -> Element? {
        return isEmpty ? nil : storage.removeFirst()
    }
}

extension Queue: CustomStringConvertible {
    public var description: String {
        return String(describing: storage)
    }
}

