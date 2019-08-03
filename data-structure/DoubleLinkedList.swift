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
	public var head: Node<Value>?
	public var tail: Node<Value>?
	fileprivate var size: Int
	
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
		guard !isEmpty else {
			return nil
		}
		
		let node = head
		head = head?.next
		size -= 1
		return node
	}
	
	public mutating func popLast() -> Node<Value>? {
		guard !isEmpty else {
			return nil
		}
		
		let node = tail
		tail = tail?.prev
		size -= 1
		return node
	}
	
	public mutating func remove(_ node: Node<Value>) {
		guard size > 0 else {
			return
		}
		
		if node.prev === head {
			head = node.next
		}
		if node.next === tail {
			tail = node.prev
		}
		
		size -= 1
		node.prev?.next = node.next
		node.next?.prev = node.prev
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

var anotherList = DoubleLinkedList<Int>()
anotherList.append(10)
anotherList.append(-1)
anotherList.append(-2)
anotherList.append(-3)
print(anotherList.size)

print("First list: \(list)")
print("Second list: \(anotherList)")
