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
	
	var isEmpty: Bool {
		if size > 0 {
			return false
		} else {
			return true
		}
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

// Tree Challenge
// Print all the values in a tree in an order based on their level.
// Nodes belonging in the same level should be printed in the same line.
func printEachLevel<T>(for tree: TreeNode<T>) {
	let queue = Queue<TreeNode<T>>()
	var nodesLeftIncurrentLevel = 0
	queue.enqueue(tree)
	
	while !queue.isEmpty {
		nodesLeftIncurrentLevel = queue.size
		
		while nodesLeftIncurrentLevel > 0 {
			guard let node = queue.dequeue() else { break }
			
			print("\(node.value)", terminator: " ")
			node.children.forEach { queue.enqueue($0) }
			nodesLeftIncurrentLevel -= 1
		}
		
		print()
	}
}

example(of: "print each level for tree") {
	let tree = makeBeverageTree()
	
	printEachLevel(for: tree)
}