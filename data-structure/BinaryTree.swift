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

// traversal algorithms
extension BinaryNode {
	// in-order
	public func traversalInOrder(visit: (T) -> Void) {
		leftChild?.traversalInOrder(visit: visit)
		visit(value)
		rightChild?.traversalInOrder(visit: visit)
	}
	
	// pre-order
	public func traversalPreOrder(visit: (T) -> Void) {
		visit(value)
		leftChild?.traversalPreOrder(visit: visit)
		rightChild?.traversalPreOrder(visit: visit)
	}

	// post-order
	public func traversalPostOrder(visit: (T) -> Void) {
		leftChild?.traversalPostOrder(visit: visit)
		rightChild?.traversalPostOrder(visit: visit)
		visit(value)
	}
}

func example(of title: String, excute: ()->()) {
	print("---Example of \(title)---")
	excute()
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

example(of: "tree diagram") {
	print(sampleTree())
}

example(of: "in-order traversal") {
	let tree = sampleTree()
	tree.traversalInOrder { print($0) }
}

example(of: "pre-order traversal") {
	let tree = sampleTree()
	tree.traversalPreOrder { print($0) }
}

example(of: "post-order traversal") {
	let tree = sampleTree()
	tree.traversalPostOrder { print($0) }
}