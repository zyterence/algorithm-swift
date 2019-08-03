public class Node<Value> {
	public var value: Value
	public var next: Node?
	public weak var prev: Node?
	
	public init(value: Value, next: Node? = nil, prev: Node? = nil) {
		self.value = value
		self.next = next
		self.prev = prev
	}
}

extension Node: CustomStringConvertible {
	public var description: String {
		guard let next = next else {
			return "\(value) = tail"
		}
		
		if prev == nil {
			return "head = \(value) <-> " + String(describing: next)
		} else {
			return "\(value) <-> " + String(describing: next)
		}
	}
}

public struct DoubleLinkedList<Value> {
	private(set) var head: Node<Value>?
	private(set) var tail: Node<Value>?
	private(set) var size: Int
	
	public init() {
		size = 0
	}
	
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
		size += 1
	}
	
	public mutating func append(_ value: Value) {
		guard !isEmpty else {
			push(value)
			return
		}
		
		let node = Node(value: value, next: nil, prev: tail)
		tail?.next = node
		tail = node
		size += 1
	}
	
	public mutating func pop() -> Node<Value>? {
		guard let node = head else {
			return nil
		}
		unlink(node)
		return node
	}
	
	public mutating func popLast() -> Node<Value>? {
		guard let node = tail else {
			return nil
		}
		unlink(node)
		return node
	}
	
	public mutating func remove(_ node: Node<Value>) {
		guard size > 0 else {
			return
		}
		unlink(node)
	}
	
	private mutating func unlink(_ node: Node<Value>) {
		let before = node.prev
		let after = node.next
		
		if before != nil {
			before?.next = after
		}
		
		if after != nil {
			after?.prev = before
		}
		
		if head === node {
			head = head?.next
		} else if tail === node {
			tail = tail?.prev
		}
		
		size -= 1
	}
}

extension DoubleLinkedList: CustomStringConvertible {
	
	public var description: String {
		guard let head = head else {
			return "Empty list"
		}
		return String(describing: head)
	}
}

var list = DoubleLinkedList<Int>()
list.push(4)
list.push(3)
list.push(2)
list.push(1)
print(list.size)
list.remove(list.head!)
print(list.size)

var anotherList = DoubleLinkedList<Int>()
anotherList.append(10)
anotherList.append(-1)
anotherList.append(-2)
anotherList.append(-3)
print(anotherList.size)

print("First list: \(list)")
print("Second list: \(anotherList)")
