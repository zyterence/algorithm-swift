protocol Queue {
    associatedtype Element: Comparable
    
    @discardableResult
    func add(_ item: Element) -> Bool
    
    @discardableResult
    func remove() throws -> Element
    
    func dequeue() -> Element?
    
    func peek() -> Element?
    
    func clear() -> Void
}

enum QueueError: Error {
    case noSuchItem(String)
}


private extension Int {
    var leftChild: Int {
        return (2 * self) + 1
    }
    
    var rightChild: Int {
        return (2 * self) + 2
    }
    
    var parent: Int {
        return (self - 1) / 2
    }
}

class PriorityQueue<Element: Comparable> {
    
    private var queue: Array<Element>
    
    public var size: Int {
        return queue.count
    }
    
    public init() {
        self.queue = Array<Element>()
    }
}

extension PriorityQueue: Queue {
    
    @discardableResult
    public func add(_ item: Element) -> Bool {
        queue.append(item)
        
        return true
    }
    
    @discardableResult
    public func remove() throws -> Element {
        guard queue.count > 0 else {
            throw QueueError.noSuchItem("Attempt to remove item from an empty queue.")
        }
        return popAndHeapifyDown()
    }
    
    public func dequeue() -> Element? {
        guard queue.count > 0 else {
            return nil
        }
        return popAndHeapifyDown()
    }
    
    public func peek() -> Element? {
        return queue.first
    }
    
    public func clear() {
        self.queue.removeAll()
    }
    
    private func popAndHeapifyDown() -> Element {
        let firstItem = queue[0]
        
        if queue.count == 1 {
            queue.remove(at: 0)
            return firstItem
        }
        
        queue[0] = queue.remove(at: queue.count - 1)
        
        heapifyDown()
        
        return firstItem
    }
    
    private func heapifyUp(from index: Int) {
        var child = index
        var parent = child.parent
        
        while parent >= 0 && self.queue[parent] > self.queue[child] {
            swap(parent, with: child)
            child = parent
            parent = child.parent
        }
    }
    
    private func heapifyDown() {
        var parent = 0
        
        while true {
            let leftChild = parent.leftChild
            if leftChild >= queue.count {
                break
            }
            
            let rightChild = parent.rightChild
            var minChild = leftChild
            if rightChild < queue.count && queue[minChild] > queue[rightChild] {
                minChild = rightChild
            }
            
            if queue[parent] > queue[minChild] {
                swap(parent, with: minChild)
                parent = minChild
            } else {
                break
            }
        }
    }
    
    
    private func swap(_ firstIndex: Int, with secondIndex: Int) {
        let firstItem = queue[firstIndex]
        queue[firstIndex] = self.queue[secondIndex]
        queue[secondIndex] = firstItem
    }
}
