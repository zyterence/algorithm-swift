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
    
    private func remove(node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>? {
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

extension BinaryNode where T: Comparable {
    
    var isBinarySearchTree: Bool {
        return isBST(self, min: nil, max: nil)
    }
    
    private func isBST(_ tree: BinaryNode<T>?, min: T?, max: T?) -> Bool {
        guard let tree = tree else {
            return true
        }
        
        if let min = min, tree.value <= min {
            return false
        } else if let max = max, tree.value > max {
            return false
        }
        
        return isBST(tree.leftChild, min: min, max: tree.value) &&
                isBST(tree.rightChild, min: tree.value, max: max)
    }
}

extension BinarySeachTree: Equatable {
    
    public static func ==(lhs: BinarySeachTree, rhs: BinarySeachTree) -> Bool {
        return isEqual(lhs.root, rhs.root)
    }
    
    private static func isEqual<T: Equatable>(_ node1: BinaryNode<T>?, _ node2: BinaryNode<T>?) -> Bool {
        guard let leftNode = node1, let rightNode = node2 else {
            return node1 == nil && node2 == nil
        }
        
        return leftNode.value == rightNode.value &&
                isEqual(leftNode.leftChild, rightNode.leftChild) &&
                isEqual(leftNode.rightChild, rightNode.rightChild)
    }
}


