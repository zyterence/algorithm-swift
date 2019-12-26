public protocol Set {
    
    associatedtype Element
    
    var size: Int { get }
    var isEmpty: Bool { get }
    
    func add(_ element: Element)
    func remove(_ element: Element)
    func contains(_ element: Element) -> Bool
}

