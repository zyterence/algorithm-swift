public class BinaryNode<T> {
	public var value: T
	public var leftChild: BinaryNode?
	public var rightChild: BinaryNode?
	
	public init(value: T) {
		self.value = value
	}
}

private extension BinaryNode {
	var min: BinaryNode {
		return leftChild?.min ?? self
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

public struct BinarySeachTree<Element: Comparable> {
	
	public private(set) var root: BinaryNode<Element>?
	
	public init() { }
}

extension BinarySeachTree: CustomStringConvertible {
	
	public var description: String {
		guard let root = root else { return "empty tree" }
		return String(describing: root)
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

extension BinarySeachTree {
	
	public mutating func insert(_ value: Element) {
		root = insert(from: root, value: value)
	}
	
	private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
		
		guard let node = node else {
			return BinaryNode(value: value)
		}
		
		if value < node.value {
			node.leftChild = insert(from: node.leftChild, value: value)
		} else {
			node.rightChild = insert(from: node.rightChild, value: value)
		}
		
		return node
	}
	
	public func contains(_ value: Element) -> Bool {
		guard let root = root else {
			return false
		}
		var found = false
		root.traversalInOrder {
			if $0 == value {
				found = true
			}
		}
		
		return found
	}
	
	public mutating func remove(_ value: Element) {
		root = remove(node: root, value: value)
	}
	
	private func remove(node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>? {
		
		return root
	}
}

func example(of title: String, excute: ()->()) {
	print("---Example of \(title)---")
	excute()
}

var exampleTree: BinarySeachTree<Int> {
	var bst = BinarySeachTree<Int>()
	bst.insert(3)
	bst.insert(1)
	bst.insert(4)
	bst.insert(0)
	bst.insert(2)
	bst.insert(5)
	return bst
}

example(of: "building a BST") {
	print(exampleTree)
}

example(of: "finding a node") {
	if exampleTree.contains(5) {
		print("Found 5!")
	} else {
		print("Couldn't find 5")
	}
}
