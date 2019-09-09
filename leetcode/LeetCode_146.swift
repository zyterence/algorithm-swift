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

class LRUCache {
	private var capacity: Int
	private var list: DoubleLinkedList<Int, Int>
	private var map: Dictionary<Int, Node<Int, Int>>
	
	public init(_ capacity: Int) {
		if capacity > 1 {
			self.capacity = capacity
		} else {
			self.capacity = 1
		}
		self.list = DoubleLinkedList()
		self.map = Dictionary()
	}
	
	public func get(_ key: Int) -> Int {
		if self.contains(key) {
			let node = map[key]!
			list.remove(node)
			map[key] = list.push(key:key, value:node.value)
			return node.value
		} else {
			return -1
		}
	}
	
	public func put(_ key: Int, _ value: Int) {
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
	
	public func contains(_ key: Int) -> Bool {
		if map.keys.contains(key)  {
			return true
		} else {
			return false
		}
	}
}

// Runtime: 448 ms, faster than 21.66% of Swift online submissions for LRU Cache.
// Memory Usage: 24 MB, less than 25.00% of Swift online submissions for LRU Cache.
extension LRUCache {
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
		print("head == \(node!.key): \(node!.value)")
		
		while let next = node?.next {
			print("\(next.key): \(next.value)")
			node = node?.next
		}
	}
}

let cache = LRUCache(2)

//cache.put(1, 111)
//cache.put(2, 222)
//cache.put(3, 333)
//
//cache.printAll()
//cache.printList()
//
//cache.put(2, 2222)
//cache.printAll()
//cache.printList()
//
//cache.put(5, 555)
//cache.printAll()
//cache.printList()
cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // 返回  1
cache.printAll()
cache.printList()
cache.put(3, 3);    // 该操作会使得密钥 2 作废
cache.get(2);       // 返回 -1 (未找到)
cache.put(4, 4);    // 该操作会使得密钥 1 作废
cache.get(1);       // 返回 -1 (未找到)
cache.get(3);       // 返回  3
cache.get(4);       // 返回  4

cache.printAll()
cache.printList()
