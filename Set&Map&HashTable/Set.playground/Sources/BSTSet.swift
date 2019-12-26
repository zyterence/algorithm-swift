public class BSTSet<Element: Comparable>: Set {
    
    private var tree = BinarySeachTree<Element>()
    
    public init() {}
    
    public init(_ value: Element) {
        tree.insert(value)
    }
    
    public init(_ array: [Element]) {
        for item in array {
            if !tree.contains(item) {
                tree.insert(item)
            }
        }
    }
    
    public var size: Int {
        return tree.size
    }
    
    public var isEmpty: Bool {
        return tree.isEmpty
    }
    
    public func add(_ element: Element) {
        if !tree.contains(element) {
            tree.insert(element)
        }
    }
    
    public func remove(_ element: Element) {
        if tree.contains(element) {
            tree.remove(element)
        }
    }
    
    public func contains(_ element: Element) -> Bool {
        return tree.contains(element)
    }
}
