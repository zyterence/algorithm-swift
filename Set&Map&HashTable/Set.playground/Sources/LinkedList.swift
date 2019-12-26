public class Node<Value> {

    public var value: Value
    public var next: Node?

    public init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

extension Node: CustomStringConvertible {

    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        
        return "\(value) -> " + String(describing: next) + " "
    }
}

public struct LinkedList<Value> where Value: Equatable {
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var size: Int {
        guard head != nil else {
            return 0
        }
        
        var currentNode = head
        var count: Int = 0
        while currentNode != nil {
            currentNode = currentNode!.next
            count += 1
        }
        
        return count
    }
    
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    public func node(at index: Int) -> Node<Value>? {
        
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    public func contains(_ value: Value) -> Bool {
        var currentNode = head
        
        while currentNode != nil {
            if currentNode!.value == value {
                return true
            }
            currentNode = currentNode!.next
        }
        
        return false
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    public mutating func remove(_ value: Value) {
        var preNode = head
        var currentNode = head?.next
        if head != nil && head!.value == value {
            head = head?.next
        }
        
        while currentNode != nil {
            if currentNode!.value == value {
                preNode?.next = currentNode?.next
            }
            preNode = currentNode
            currentNode = currentNode!.next
        }
    }
}

extension LinkedList: CustomStringConvertible {
    
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}
