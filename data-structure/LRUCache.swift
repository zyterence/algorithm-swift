public class Node<Key, Value> {
	public var key: Key
	public var value: Value
	public var next: Node?
	public var prev: Node?
	
	public init(key: Key, value: Value, next: Node? = nil, prev: Node? = nil) {
		self.key = key
		self.value = value
		self.next = next
		self.prev = prev
	}
}

public struct DoubleLinkedList<Key, Value> {
	public var head: Node<Key, Value>?
	public var tail: Node<Key, Value>?
	fileprivate var size: Int
	
	public init() {
		size = 0
	}
	
	public var isEmpty: Bool {
		return head == nil
	}
	
	public mutating func push(key: Key, value: Value) {
		let node = Node(key: key, value: value, next: head, prev: nil)
		head?.prev = node
		head = node
		if tail == nil {
			tail = head
		}
		size += 1
	}
	
	public mutating func append(key: Key, value: Value) {
		guard !isEmpty else {
			push(key: key, value: value)
			return
		}
		
		tail!.next = Node(key: key, value: value, next: nil, prev: tail)
		tail = tail!.next
		size += 1
	}
	
	public mutating func pop() -> Node<Key, Value>? {
		guard !isEmpty else {
			return nil
		}
		
		let node = head
		head = head?.next
		size -= 1
		return node
	}
	
	public mutating func popLast() -> Node<Key, Value>? {
		guard !isEmpty else {
			return nil
		}
		
		let node = tail
		tail = tail?.prev
		size -= 1
		return node
	}
	
	public mutating func remove(_ node: Node<Key, Value>) {
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

class LRUCache<Key: Hashable, Value> {
	private var capacity: Int
	private var list: DoubleLinkedList<Key, Value>
	private var map: Dictionary<Key, Node<Key, Value>>
	
	public init(_ capacity: Int) {
		if capacity > 1 {
			self.capacity = capacity
		} else {
			self.capacity = 1
		}
		self.list = DoubleLinkedList()
		self.map = Dictionary()
	}
	
	public func get(_ key: Key) -> Value? {
		if self.contains(key) {
			let node = map[key]
			
			return node?.value
		} else {
			return nil	
		}
	}
	
	public func set(_ key: Key, _ value: Value) {
		if self.contains(key) {
			
		} else {
			if list.size == capacity {
				
			} else {
				
			}
		}
	}
	
	public func contains(_ key: Key) -> Bool {
		if map.keys.contains(key)  {
			return true
		} else {
			return false
		}
	}
}

let cache = LRUCache<String, String>(10)
