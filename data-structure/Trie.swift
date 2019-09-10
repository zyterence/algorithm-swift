public class TrieNode<Key: Hashable> {
	
	public var key: Key?
	
	public weak var parent: TrieNode?
	
	public var children: [Key: TrieNode] = [:]
	
	public var isTerminating = false
	
	public init(key: Key?, parent: TrieNode?) {
		self.key = key
		self.parent = parent
	}
	
}

public class Trie<CollectionType: Collection & Hashable> where CollectionType.Element: Hashable {
	
	public typealias Node = TrieNode<CollectionType.Element>
	
	private let root = Node(key: nil, parent: nil)
	
	public private(set) var collections: Set<CollectionType> = []
	
	public var count: Int {
		return collections.count
	}
	
	public var isEmpty: Bool {
		return collections.isEmpty
	}
	
	public init() {}
	
	public func insert(_ collection: CollectionType) {
		
		var current = root
		
		for element in collection {
			if current.children[element] == nil {
				current.children[element] = Node(key: element, parent: current)
			}
			current = current.children[element]!
		}
		
		if current.isTerminating {
			return
		} else {
			current.isTerminating = true
			collections.insert(collection)
		}
	}
	
	public func contains(_ collection: CollectionType) -> Bool {
		
		var current = root
		
		for element in collection {
			guard let child = current.children[element] else {
				return false
			}
			current = child
		}
		
		return current.isTerminating
	}
	
	public func remove(_ collection: CollectionType) {
		
		var current = root
		
		for element in collection {
			guard let child = current.children[element] else {
				return
			}
			current = child
		}
		
		guard current.isTerminating else {
			return
		}
		
		current.isTerminating = false
		collections.remove(collection)
		
		while let parent = current.parent, current.children.isEmpty && !current.isTerminating {
			parent.children[current.key!] = nil
			current = parent
		}
	}

}

public extension Trie where CollectionType: RangeReplaceableCollection {
	
	func collections(startingWith prefix: CollectionType) -> [CollectionType] {
		
		var current = root
		
		for element in prefix {
			guard let child = current.children[element] else {
				return []
			}
			
			current = child
		}
		
		return collections(startingWith: prefix, after: current)
	}
	
	private func collections(startingWith prefix: CollectionType, after node: Node) -> [CollectionType] {
		
		var results: [CollectionType] = []
		
		if node.isTerminating {
			results.append(prefix)
		}
		
		for child in node.children.values {
			var prefix = prefix
			prefix.append(child.key!)
			results.append(contentsOf: collections(startingWith: prefix, after: child))
		}
		
		return results
	}
}

func example(of title: String, excute: ()->()) {
	print("---"+title+"---")
	excute()
}

example(of: "insert and contains") {
	let trie = Trie<String>()
	trie.insert("cute")
	if trie.contains("cute") {
		print("cute is in the trie")
	}
}

example(of: "remove") {
	let trie = Trie<String>()
	trie.insert("cut")
	trie.insert("cute")
	
	print("\n*** Before removing ***")
	assert(trie.contains("cut"))
	print("\"cut\" is in the trie")
	assert(trie.contains("cute"))
	print("\"cute\" is in the trie")
	
	print("\n*** After removing cut ***")
	trie.remove("cut")
	assert(!trie.contains("cut"))
	assert(trie.contains("cute"))
	print("\"cute\" is still in the trie")
}

example(of: "prefix matching") {
	let trie = Trie<String>()
	trie.insert("car")
	trie.insert("card")
	trie.insert("care")
	trie.insert("cared")
	trie.insert("cars")
	trie.insert("carbs")
	trie.insert("carapace")
	trie.insert("cargo")
	
	print("\nCollections starting with \"car\"")
	let prefixedWithCar = trie.collections(startingWith: "car")
	print(prefixedWithCar)
	
	print("\nCollections starting with \"care\"")
	let prefixedWithCare = trie.collections(startingWith: "care")
	print(prefixedWithCare)
}