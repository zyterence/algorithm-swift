public class Node<Value> {
    
    public var value: Value
    public var next: Node?
    public var prev: Node?
    
    public init(value: Value, next: Node? = nil, prev: Node? = nil) {
        self.value = value
        self.next = next
        self.prev = prev
    }
}

extension Node: CustomStringConvertible {
    
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        
        return "\(value) <-> " + String(describing: next) + " "
    }
}

public struct LinkedList<Value> {
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public mutating func push(_ value: Value) {
        let node = Node(value: value, next: head, prev: nil)
        head?.prev = node
        head = node
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail!.next = Node(value: value, next: nil, prev: tail)
        tail = tail!.next
    }
    
    public func node(at index: Int) -> Node<Value>? {
        
        var currentNode = head
        var currentIndex = 0
        
        
        
        return currentNode
        
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

func example(of title: String, excute: ()->()) {
    print("---Example of \(title)---")
    excute()
}

example(of: "creating and linking nodes") {
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    
    node1.next = node2
    node2.prev = node1
    node2.next = node3
    node3.prev = node2
    
    print(node1)
}

example(of: "push") {
    var list = LinkedList<Int>()
    
    list.push(3)
    list.push(2)
    list.push(1)
    
    print(list)
}

example(of: "append") {
    var list = LinkedList<Int>()
    
    list.append(1)
    list.append(2)
    list.append(3)
    
    print(list)
}
