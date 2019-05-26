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

public struct LinkedList<Value> where Value: Comparable {
    
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public mutating func push(_ value: Value) {
        copyNodes()
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        copyNodes()
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
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        copyNodes()
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        copyNodes()
        return head?.value
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        copyNodes()
        guard let head = head else {
            return nil
        }
        
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        return current.value
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        copyNodes()
        return node.next?.value
    } 
    
    private mutating func copyNodes() {
        guard var oldNode = head, !isKnownUniquelyReferenced(&head) else {
            return
        }
        
        head = Node(value: oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            oldNode = nextOldNode
        }
        
        tail = newNode
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

extension LinkedList: Collection {
    
    public struct Index: Comparable {
        
        public var node: Node<Value>?
        
        static public func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        static public func <(lhs: Index, rhs: Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            
            let nodes = sequence(first: lhs.node) { $0?.next }
            
            return nodes.contains { $0 === rhs.node }
        }
    }
    
    public var startIndex: LinkedList<Value>.Index {
        return Index(node: head)
    }
    
    public var endIndex: LinkedList<Value>.Index {
        return Index(node: tail?.next)
    }
    
    public func index(after i: LinkedList<Value>.Index) -> LinkedList<Value>.Index {
        return Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> Value {
        return position.node!.value
    }
}

// linked list challenges
extension LinkedList {
    
    // Challenge 1: Create a function that prints out the elements of a linked list in reverse order
    static func printInReverse(_ node: Node<Value>?) {
        guard let node = node else { return }
        
        printInReverse(node.next)
        
        print(node.value)
    }
    
    // Challenge 2: Create a function that returns the middle node of a linked list
    func getMiddleNode() -> Node<Value>? {
        var slow = head
        var fast = head
        
        while let nextFast = fast?.next {
            fast = nextFast.next
            slow = slow?.next
        }
        
        return slow
    }
    
    // Challenge 3: Create a function that reverses a linked list
    mutating func reverse() {
        copyNodes()
        
        tail = head
        var prev = head
        var current = head?.next
        prev?.next = nil
        
        while current != nil {
            let next = current?.next
            current?.next = prev
            prev = current
            current = next
        }
        
        head = prev
    }
    
    // Challenge 4: Create a function that takes two sorted linked lists and merges them into a single sorted linked list
    static func merge(_ left: LinkedList, _ right: LinkedList) -> LinkedList {
        guard !left.isEmpty else { return right }
        guard !right.isEmpty else { return left }
        
        var newHead: Node<Value>?
        var tail: Node<Value>?
        
        var currentLeft = left.head
        var currentRight = right.head
        
        if let leftNode = currentLeft, let rightNode = currentRight {
            if leftNode.value < rightNode.value {
                newHead = leftNode
                currentLeft = leftNode.next
            } else {
                newHead = rightNode
                currentRight = rightNode.next
            }
            tail = newHead
        }
        
        while let leftNode = currentLeft, let rightNode = currentRight {
            if leftNode.value < rightNode.value {
                tail?.next = leftNode
                currentLeft = leftNode.next
            } else {
                tail?.next = rightNode
                currentRight = rightNode.next
            }
            tail = tail?.next
        }
        
        if let leftNodes = currentLeft {
            tail?.next = leftNodes
        }
        
        if let rightNodes = currentRight {
            tail?.next = rightNodes
        }
        
        var list = LinkedList<Value>()
        list.head = newHead
        list.tail = {
            while let next = tail?.next {
                tail = next
            }
            return tail
        }()
        
        return list
    }
    
    // Challenge 5: Create a function that removes all occurrences of a specific element from a linked list
    
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
    node2.next = node3
    
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

example(of: "inserting at a particular index") {
    var list =  LinkedList<Int>()
    
    list.append(1)
    list.append(2)
    list.append(3)
    
    print("Before inserting: \(list)")
    var middleNode = list.node(at: 1)!
    
    for _ in 1...4 {
        middleNode = list.insert(-1, after: middleNode)
    }
    
    print("After inserting: \(list)")
}

example(of: "pop") {
    var list = LinkedList<Int>()
    
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Before popping list: \(list)")
    let poppedValue = list.pop()
    print("After popping list: \(list)")
    print("Popped value: " + String(describing: poppedValue))
}

example(of: "removing the last node") {
    var list = LinkedList<Int>()
    
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Before removing last node: \(list)")
    let removedValue = list.removeLast()
    
    print("After removing last node: \(list)")
    print("Removed value: " + String(describing: removedValue))
}

example(of: "removing a node after a particular node") {
    var list = LinkedList<Int>()
    
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Before removing at particular index: \(list)")
    
    let index = 1
    let node = list.node(at: index - 1)!
    let removedValue = list.remove(after: node)
    
    print("After removing at index \(index): \(list)")
    print("Removed value: " + String(describing: removedValue))
}

example(of: "using collection") {
    var list = LinkedList<Int>()
    
    for i in 0...9 {
        list.append(i)
    }
    
    print("List: \(list)")
    print("First element: \(list[list.startIndex])")
    print("Last element: \(list.endIndex)")
    print("Array containing first 3 elements: \(Array(list.prefix(3)))")
    print("Array containing last 3 elements: \(Array(list.suffix(3)))")
    
    let sum = list.reduce(0, +)
    print("Sum of all values: \(sum)")
}

example(of: "linked list cow") {
    var list1 = LinkedList<Int>()
    list1.append(1)
    list1.append(2)
    print("List1 uniquely referenced: \(isKnownUniquelyReferenced(&list1.head))")
    var list2 = list1
    print("List1 uniquely referenced: \(isKnownUniquelyReferenced(&list1.head))")
    print("List1: \(list1)")
    print("List2: \(list2)")
    
    print("After appending 3 to list2")
    list2.append(3)
    print("List1: \(list1)")
    print("List2: \(list2)")
}

example(of: "reverse") {
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    
    print("original list")
    print(list)
    print("reversed values")
    LinkedList.printInReverse(list.head)
}

example(of: "getting the middle node") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)

    print(list)

    if let middleNode = list.getMiddleNode() {
        print(middleNode)
    }
}

example(of: "reversing a list") {
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Original list: \(list)")
    list.reverse()
    print("Reversed list: \(list)")
}

example(of: "mergeing two sorted list") {
    var list = LinkedList<Int>()
    list.push(4)
    list.push(3)
    list.push(2)
    list.push(1)
    var anotherList = LinkedList<Int>()
    anotherList.push(10)
    anotherList.push(-1)
    anotherList.push(-2)
    anotherList.push(-3)
    
    print("First list: \(list)")
    print("Second list: \(anotherList)")
    let mergedList = LinkedList.merge(list, anotherList)
    print("Merged list: \(mergedList)")
}
