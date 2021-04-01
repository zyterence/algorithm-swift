public protocol SortedSet {
	associatedtype Element: Comparable
	init()
	func contains(_ element: Element) -> Bool
	mutating func insert(_ newElement: Element) -> (inserted: Bool, memberAfterInserted: Element)
}

// 语义要求：
// - 有序
// - 值语义、写时复制

//extension SortedSet {
//	public var description: String {
//		let contents = self.lazy.map { "\($0)" }.joined(separator: ", ")
//		return "[\(contents)]"
//	}
//}


public struct SortedArray<Element: Comparable>: SortedSet {
	fileprivate var storage: [Element] = []
	public init() {} 
}

extension SortedArray where Element: Comparable {
	func index(_ element: Element) -> Int {
		var start = 0
		var end = storage.count
		while start < end {
			let middle = start + (end-start)/2
			if element > storage[middle] {
				start = middle + 1
			} else {
				end = middle
			}
		}
		return start
	}
	
	func index(of element: Element) -> Int? {
		let index = self.index(element)
		guard index < storage.count, storage[index] == element else { return nil }
		return index
	}
	
	public func contains(_ element: Element) -> Bool {
		let index = self.index(element)
		return index < storage.count && storage[index] == element 
	}
	
	public func forEach(_ body: (Element) throws -> Void) rethrows {
		try storage.forEach(body) 
	}
	
	public func sorted() -> [Element] {
		return storage
	}
	
	@discardableResult
	public mutating func insert(_ newElement: Element) -> (inserted: Bool, memberAfterInserted: Element)	{
		let index = self.index(newElement)
		if index < storage.count && storage[index] == newElement {
			return (false, storage[index]) 
		}
		storage.insert(newElement, at: index)
		return (true, newElement)
	}
}