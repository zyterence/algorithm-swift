public class AVLNode<T> {
	public var value: T
	public var leftChild: AVLNode?
	public var rightChild: AVLNode?
	public var height = 0
	
	public init(value: T) {
		self.value = value
	}
}

extension AVLNode {
	var min: AVLNode {
		return leftChild?.min ?? self
	}
	
	public var balanceFactor: Int {
		return leftHeight - rightHeight
	}
	
	public var leftHeight: Int {
		return leftChild?.height ?? -1
	}
	
	public var rightHeight: Int {
		return rightChild?.height ?? -1
	}
}

extension AVLNode: CustomStringConvertible {
	public var description: String {
		return diagram(for: self)
	}
	
	private func diagram(for node: AVLNode?, 
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

public struct AVLTree<Element: Comparable> {
	
	public private(set) var root: AVLNode<Element>?
	
	public init() { }
}

extension AVLTree: CustomStringConvertible {
	
	public var description: String {
		guard let root = root else { return "empty tree" }
		return String(describing: root)
	}
}

// traversal algorithms
extension AVLNode {
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

extension AVLTree {
	
	public mutating func insert(_ value: Element) {
		root = insert(from: root, value: value)
	}
	
	private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
		
		guard let node = node else {
			return AVLNode(value: value)
		}
		
		if value < node.value {
			node.leftChild = insert(from: node.leftChild, value: value)
		} else {
			node.rightChild = insert(from: node.rightChild, value: value)
		}
		
		return node
	}
	
	public func contains(_ value: Element) -> Bool {
		var current = root
		
		while let node = current {
			if node.value == value {
				return true
			}
			
			if value < node.value {
				current = node.leftChild
			} else {
				current = node.rightChild
			}
		}
		return false
	}
	
	public mutating func remove(_ value: Element) {
		root = remove(node: root, value: value)
	}
	
	private func remove(node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
		guard let node = node else {
			return nil
		}
		
		if value == node.value {
			if node.leftChild == nil && node.rightChild == nil {
				return nil
			}
			
			if node.leftChild == nil {
				return node.rightChild
			}
			
			if node.rightChild == nil {
				return node.leftChild
			}
			
			node.value = node.rightChild!.min.value
			node.rightChild = remove(node: node.rightChild, value: node.value)
		} else if value < node.value {
			node.leftChild = remove(node: node.leftChild, value: value)
		} else {
			node.rightChild = remove(node: node.rightChild, value: value)
		}
		
		return node
	}
}

// balance
extension AVLTree {
	
	private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
		
	}
	
	private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
		
	}

	private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
		
	}

	private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
		
	}
	
	private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
		
	}
}

func example(of title: String, excute: ()->()) {
	print("---Example of \(title)---")
	excute()
}

var exampleTree: AVLTree<Int> {
	var avl = AVLTree<Int>()
	avl.insert(3)
	avl.insert(1)
	avl.insert(4)
	avl.insert(0)
	avl.insert(2)
	avl.insert(5)
	return avl
}