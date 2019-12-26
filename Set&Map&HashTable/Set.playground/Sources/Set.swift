public protocol Set {
    
    associatedtype Element
    
    func add(_ element: Element)
    func remove(_ element: Element)
    func contains(_ element: Element) -> Bool
    var size: Int { get }
    var empty: Bool { get }
}

