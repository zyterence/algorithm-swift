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

// Challenge 1: Given a binary tree, find the height of the tree.
func height<T>(of node: BinaryNode<T>?) -> Int {
	guard let node = node else {
		return -1
	}
	return 1 + max(height(of: node.leftChild), height(of: node.rightChild))
}

example(of: "binary tree height") {
	let tree = sampleTree()
	print(height(of: tree))
	let single = BinaryNode<Int>(value: 10)
	print(height(of: single))
	let empty: BinaryNode<Int>? = nil
	print(height(of: empty))
}

// Challenge 2: Devise a way to serialize a binary tree into an array, 
// and a way to deserialize the array back into the binary tree.
// input
//	 ┌──nil
//	┌──25
//	│ └──17
//	15
//	│ ┌──12
//	└──10
//	 └──5
// output
// [15, 10, 5, nil, nil, 12, nil, nil, 25, 17, nil, nil, nil]
extension BinaryNode {
	public func traversalPreOrder(visit: (T?) -> Void) {
		visit(value)
		if let leftChild = leftChild {
			leftChild.traversalPreOrder(visit: visit)
		} else {
			visit(nil)
		}
		if let rightChild = rightChild {
			rightChild.traversalPreOrder(visit: visit)
		} else {
			visit(nil)
		}
	}
}

func serialize<T>(_ node: BinaryNode<T>) -> [T?] {
	var array: [T?] = []
	node.traversalPreOrder { array.append($0) }
	return array
}

func deserialize<T>(_ array: inout [T?]) -> BinaryNode<T>? {
	guard let value = array.removeFirst() else {
		return nil
	}
	
	let node = BinaryNode(value: value)
	node.leftChild = deserialize(&array)
	node.rightChild = deserialize(&array)
	return node
}

example(of: "serialize a tree into an array") {
	let tree = sampleTree()
	var array = serialize(tree)
	print(array)
	let node = deserialize(&array)
	print(node!)
}
