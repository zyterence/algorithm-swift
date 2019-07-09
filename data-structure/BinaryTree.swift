public class BinaryNode<T> {
	public var value: T
	public var leftChild: BinaryNode?
	public var rightChild: BinaryNode?
	
	public init(value: T) {
		self.value = value
	}
}

extension BinaryNode: CustomStringConvertible {
	public var description: String {
		return diagram(for: self)
	}
	
	private func diagram(for node: BinaryNode?, 
						_ top: String = "",
						_ root: String = "",
						_ bottom: String = "") -> String {
	
		guard let node = node else {
			return root + "nil\n"
		}
		if node.leftChild == nil && node.rightChild == nil {
			return root + "\(node.value)\n"
		}
		return diagram(for: node.rightChild, top + " ", top + "┌──", top + "│ ") 
					+ root + "\(node.value)\n" 
					+ diagram(for: node.leftChild, bottom + "│ ", bottom + "└──", bottom + " ")
	}
}

func example(of title: String, excute: ()->()) {
	print("---Example of \(title)---")
	excute()
}

class Queue<T> {
	private var queue: Array<T>
	
	public var size: Int {
		return queue.count
	}
	
	public init() {
		self.queue = Array<T>()
	}
	
	@discardableResult
	func enqueue(_ item: T) -> Bool {
		queue.append(item)
		return true
	}
	
	func dequeue() -> T? {
		guard queue.count > 0 else {
			return nil
		}
		defer {
			queue.remove(at: 0)
		}
		return queue.first
	}
	
	var isEmpty: Bool {
		if size > 0 {
			return false
		} else {
			return true
		}
	}
}

func sampleTree() -> BinaryNode<Int> {
	let zero = BinaryNode(value: 0)
	let one = BinaryNode(value: 1)
	let five = BinaryNode(value: 5)
	let seven = BinaryNode(value: 7)
	let eight = BinaryNode(value: 8)
	let nine = BinaryNode(value: 9)
	
	seven.leftChild = one
	seven.rightChild = nine
	one.leftChild = zero
	one.rightChild = five
	nine.leftChild = eight
	
	return seven
}

func printEachLevel<T>(for tree: BinaryNode<T>) {
	let queue = Queue<BinaryNode<T>>()
	var nodesLeftIncurrentLevel = 0
	queue.enqueue(tree)
	
	while !queue.isEmpty {
		nodesLeftIncurrentLevel = queue.size
		
		while nodesLeftIncurrentLevel > 0 {
			guard let node = queue.dequeue() else { break }
			
			print("\(node.value)", terminator: " ")
//			node.children.forEach { queue.enqueue($0) }
			if let left = node.leftChild {
				queue.enqueue(left)
			}
			if let right = node.rightChild {
				queue.enqueue(right)
			}
			nodesLeftIncurrentLevel -= 1
		}
		
		print()
	}
}

example(of: "print each level for tree") {
	let tree = sampleTree()
	
	printEachLevel(for: tree)
}

example(of: "tree diagram") {
	print(sampleTree())
}
