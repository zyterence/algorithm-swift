class BinaryNode<Key: Comparable, Value> {
    
    var leftChild: BinaryNode?
    var rightChild: BinaryNode?
    var parent: BinaryNode?
    
    var key: Key
    var value: Value
    
    public init(key: Key, value: Value, leftChild: BinaryNode? = nil, rightChild: BinaryNode? = nil, parent: BinaryNode? = nil) {
        self.key = key
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.parent = parent
    }
    
    public init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
    
    public func statuare() -> Int {
        return 0
    }
    
    public func successor() -> BinaryNode? {
        return nil
    }
}

extension BinaryNode {
    
    public func traversalLevelOrder(visit: (_ key: Key, _ value: Value) -> Void) {
        
    }
    
    // in-order
    public func traversalInOrder(visit: (_ key: Key, _ value: Value) -> Void) {
        leftChild?.traversalInOrder(visit: visit)
        visit(key, value)
        rightChild?.traversalInOrder(visit: visit)
    }
    
    // pre-order
    public func traversalPreOrder(visit: (_ key: Key, _ value: Value) -> Void) {
        visit(key, value)
        leftChild?.traversalPreOrder(visit: visit)
        rightChild?.traversalPreOrder(visit: visit)
    }

    // post-order
    public func traversalPostOrder(visit: (_ key: Key, _ value: Value) -> Void) {
        leftChild?.traversalPostOrder(visit: visit)
        rightChild?.traversalPostOrder(visit: visit)
        visit(key, value)
    }
}

// Operators
extension BinaryNode {
    
    static func >(left: BinaryNode, right: BinaryNode) -> Bool {
        return left.key > right.key
    }
    
    static func <(left: BinaryNode, right: BinaryNode) -> Bool {
        return left.key < right.key
    }
    
    static func ==(left: BinaryNode, right: BinaryNode) -> Bool {
        return left.key == right.key
    }
    
    static func !=(left: BinaryNode, right: BinaryNode) -> Bool {
        return left.key != right.key
    }
}

