public class TreeNode<T> {
	public var value: T
	public var children: [TreeNode] = []
	
	public init(_ value: T) {
		self.value = value
	}
	
	public func add(_ child: TreeNode) {
		children.append(child)
	}
}

// traversal
extension TreeNode {
	public func forEachDepthFirst(visit: (TreeNode) -> Void) {
		visit(self)
		children.forEach {
			$0.forEachDepthFirst(visit: visit)
		}
	}
	
	public func forEachLevelOrder(visit: (TreeNode) -> Void) {
		visit(self)
		let queue = Queue<TreeNode>()
		children.forEach { queue.enqueue($0) }
		while let node = queue.dequeue() {
			visit(node)
			node.children.forEach { queue.enqueue($0) }
		}
	}
}

// search
extension TreeNode where T: Equatable {
	public func search(_ value: T) -> TreeNode? {
		var result: TreeNode?
		forEachLevelOrder { node in
			if node.value == value {
				result = node
			}
		}
		return result
	}
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
}

func example(of title: String, excute: ()->()) {
	print("---Example of \(title)---")
	excute()
}

example(of: "creating a tree") {
	let beverages = TreeNode("Beverages")
	let hot = TreeNode("hot")
	let cold = TreeNode("cold")
	beverages.add(hot)
	beverages.add(cold)
	for leaf in beverages.children {
		print(leaf.value)
	}
}

func makeBeverageTree() -> TreeNode<String> {
	let tree = TreeNode("Beverages")
	
	let hot = TreeNode("hot")
	let cold = TreeNode("cold")
	
	let tee = TreeNode("tee")
	let coffee = TreeNode("coffee")
	let chocolate = TreeNode("chocolate")
	
	let blackTee = TreeNode("black")
	let greenTee = TreeNode("green")
	let chaiTee = TreeNode("chai")
	
	let soda = TreeNode("soda")
	let milk = TreeNode("milk")
	
	let gingerAle = TreeNode("ginger ale")
	let bitterLemon = TreeNode("bitter lemon")
	
	tree.add(hot)
	tree.add(cold)
	
	hot.add(tee)
	hot.add(coffee)
	hot.add(chocolate)
	
	cold.add(soda)
	cold.add(milk)
	
	tee.add(blackTee)
	tee.add(greenTee)
	tee.add(chaiTee)
	
	soda.add(gingerAle)
	soda.add(bitterLemon)
	
	return tree
}

example(of: "depth-first traversal") {
	let tree = makeBeverageTree()
	tree.forEachDepthFirst {
		print($0.value)
	}
}

example(of: "level-order traversal") {
	let tree = makeBeverageTree()
	tree.forEachLevelOrder { print($0.value) }
}

example(of: "searching for a node") {
	let tree = makeBeverageTree()
	
	if let result1 = tree.search("ginger ale") {
		print("Found node: \(result1.value)")
	}
	
	if let result2 = tree.search("orenge juice") {
		print("Found node: \(result2.value)")
	} else {
		print("Couln't find orenge juice")
	}
}