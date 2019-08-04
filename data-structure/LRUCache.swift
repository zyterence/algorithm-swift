public class Node<Key, Value> {
	public var key: Key
	public var value: Value
	public var next: Node?
	public weak var prev: Node?
	
	public init(key: Key, value: Value, next: Node? = nil, prev: Node? = nil) {
		self.key = key
		self.value = value
		self.next = next
		self.prev = prev
	}
}

public struct DoubleLinkedList<Key, Value> {
	private(set) var head: Node<Key, Value>?
	private(set) var tail: Node<Key, Value>?
	private(set) var size: Int
	
	public init() {
		size = 0
	}
	
	public var isEmpty: Bool {
		return head == nil
	}
	
	@discardableResult
	public mutating func push(key: Key, value: Value) -> Node<Key, Value> {
		let node = Node(key: key, value: value, next: head, prev: nil)
		head?.prev = node
		head = node
		if tail == nil {
			tail = head
		}
		size += 1
		return node
	}
	
	@discardableResult
	public mutating func append(key: Key, value: Value) -> Node<Key, Value> {
		guard !isEmpty else {
			return push(key: key, value: value)
		}
		
		let node = Node(key: key, value: value, next: nil, prev: tail)
		tail?.next = node
		tail = node
		size += 1
		return node
	}
	
	@discardableResult
	public mutating func pop() -> Node<Key, Value>? {
		guard let node = head else {
			return nil
		}
		unlink(node)
		return node
	}
	
	@discardableResult
	public mutating func popLast() -> Node<Key, Value>? {
		guard let node = tail else {
			return nil
		}
		unlink(node)
		return node
	}
	
	public mutating func remove(_ node: Node<Key, Value>) {
		guard size > 0 else {
			return
		}
		unlink(node)
	}
	
	private mutating func unlink(_ node: Node<Key, Value>) {
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
			if let node = map[key] {
				list.remove(node)	
			}
			map[key] = list.push(key:key, value:value)
		} else {
			if list.size == capacity {
				if let node = list.popLast() {
					map.removeValue(forKey: node.key)	
				}
				map[key] = list.push(key:key, value:value)
			} else {
				map[key] = list.push(key: key, value: value)
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
		
	public func printAll() {
		print("\(map.keys.count) items in all")
		for key in map.keys {
			if let node = map[key] {
				print("key: \(node.key), value: \(node.value)")
			}
		}
	}
	
	public func printList() {
		var node = list.head
		if node == nil { return }
		print("\(node!.key): \(node!.value)")
		
		while let next = node?.next {
			print("\(next.key): \(next.value)")
			node = node?.next
		}
	}
}

let cache = LRUCache<Int, String>(3)

cache.set(1, "one")
cache.set(2, "tow")
cache.set(3, "three")

cache.printAll()
cache.printList()

cache.set(2, "four")
cache.printAll()
cache.printList()

cache.set(5, "five")
cache.printAll()
cache.printList()
