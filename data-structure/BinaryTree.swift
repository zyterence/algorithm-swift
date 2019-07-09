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
