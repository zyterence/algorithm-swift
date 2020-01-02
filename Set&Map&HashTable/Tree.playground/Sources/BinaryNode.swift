class BinaryNode<Key: Comparable, Value> {

    enum RBColor {
        case red
        case black
    }
    
    var leftChild: BinaryNode?
    var rightChild: BinaryNode?
    var parent: BinaryNode?
    
    var key: Key
    var value: Value
    var height: Int = 0
    var color: RBColor?
    
    public init(key: Key, value: Value, leftChild: BinaryNode? = nil, rightChild: BinaryNode? = nil, parent: BinaryNode? = nil, color: RBColor? = nil) {
        self.key = key
        self.value = value
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.parent = parent
        self.color = color
    }
    
    public init(key: Key, value: Value) {
        self.key = key
        self.value = value
    }
    
    public func insert(left child: BinaryNode) {
        
    }
    
    public func insert(right child: BinaryNode) {
        
    }
    
    public func succ() {
        
    }
    
}

extension BinaryNode {
    
    public func travelLevelOrder(visit: (Key, Value) -> Void) {
        
    }
    
    public func travelInOrder(visit: (Key, Value) -> Void) {
        
    }
    
    public func travelPreOrder(visit: (Key, Value) -> Value) {
        
    }
    
    public func travelPostOrder(visit: (Key, Value) -> Value) {
    
    }
    
}

extension BinaryNode {
    
    static func ==(left: BinaryNode, right: BinaryNode) -> Bool {
        return left.key == right.key
    }
    
    static func <(left: BinaryNode, right: BinaryNode) -> Bool {
        return left.key < right.key
    }
}

