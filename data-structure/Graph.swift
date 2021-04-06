public enum EdgeType {
	case directed
	case undirected
}

public struct Vertex<T> {
	public let index: Int
	public let data: T
}

public struct Edge<T> {
	public let source: Vertex<T>
	public let destination: Vertex<T>
	public let weight: Double?
}

public protocol Graph {
	associatedtype Element
	
	func createVertex(data: Element) -> Vertex<Element>
	func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
	func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, weight: Double?)
	func add(_ edge: EdgeType, from source: Vertex<Element>, to destination: Vertex<Element>, weight: Double?)
	func edges(from source: Vertex<Element>) -> [Edge<Element>]
	func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
}

extension Graph {
	
	public func addUndirectedEdge(between source: Vertex<Element>,
																and destination: Vertex<Element>,
																weight: Double?) {
		addDirectedEdge(from: source, to: destination, weight: weight)
		addDirectedEdge(from: destination, to: source, weight: weight)
	}

	public func add(_ edge: EdgeType, from source: Vertex<Element>,
																		to destination: Vertex<Element>,
																		weight: Double?) {
		switch edge {
		case .directed:
			addDirectedEdge(from: source, to: destination, weight: weight)
		case .undirected:
			addUndirectedEdge(between: source, and: destination, weight: weight)
		}
	}


}

extension Vertex: Hashable where T: Hashable {}
extension Vertex: Equatable where T: Equatable {}

extension Vertex: CustomStringConvertible {
	
	public var description: String {
		"\(index): \(data)"
	}
}

public class AdjacencyList<T: Hashable>: Graph {
	
	private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
	
	public init() {}
	
	public func createVertex(data: T) -> Vertex<T> {
		let vertex = Vertex(index: adjacencies.count, data: data)
		adjacencies[vertex] = []
		return vertex
	}
	
	public func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, weight: Double?) {
		let edge = Edge(source: source, destination: destination, weight: weight)
		adjacencies[source]?.append(edge)
	}

	public func edges(from source: Vertex<T>) -> [Edge<T>] {
		adjacencies[source] ?? []
	}
	
	public func weight(from source: Vertex<T>,
											to destination: Vertex<T>) -> Double? {
		edges(from: source)
				.first { $0.destination == destination }?
				.weight
	}
}

extension AdjacencyList: CustomStringConvertible {
	
	public var description: String {
		var result = ""
		for (vertex, edges) in adjacencies { // 1
			var edgeString = ""
			for (index, edge) in edges.enumerated() { // 2
				if index != edges.count - 1 {
					edgeString.append("\(edge.destination), ")
				} else {
					edgeString.append("\(edge.destination)")
				}
			}
			result.append("\(vertex) ---> [ \(edgeString) ]\n") // 3
		}
		return result
	}
}


public class AdjacencyMatrix<T>: Graph {
	
	private var vertices: [Vertex<T>] = []
	private var weights: [[Double?]] = []
	
	public init() {}
	
	public func createVertex(data: T) -> Vertex<T> {
		let vertex = Vertex(index: vertices.count, data: data)
		vertices.append(vertex) // 1
		for i in 0..<weights.count { // 2
			weights[i].append(nil)
		}
		let row = [Double?](repeating: nil, count: vertices.count) // 3
		weights.append(row)
		return vertex
	}
	
	public func addDirectedEdge(from source: Vertex<T>,
															to destination: Vertex<T>, weight: Double?) {
		weights[source.index][destination.index] = weight
	}

	public func edges(from source: Vertex<T>) -> [Edge<T>] {
		var edges: [Edge<T>] = []
		for column in 0..<weights.count {
			if let weight = weights[source.index][column] {
				edges.append(Edge(source: source,
													destination: vertices[column],
													weight: weight))
			}
		}
		return edges
	}
	
	public func weight(from source: Vertex<T>,
											to destination: Vertex<T>) -> Double? {
		weights[source.index][destination.index]
	}
}

extension AdjacencyMatrix: CustomStringConvertible {
	
	public var description: String {
		// 1
		let verticesDescription = vertices.map { "\($0)" }.joined(separator: "\n")
		// 2
		var grid: [String] = []
		for i in 0..<weights.count {
			var row = ""
			for j in 0..<weights.count {
				if let value = weights[i][j] {
					row += "\(value)\t"
				} else {
					row += "ø\t\t"
				}
			}
			grid.append(row)
		}
		let edgesDescription = grid.joined(separator: "\n")
		// 3
		return "\(verticesDescription)\n\n\(edgesDescription)"
	}
}



let graph = AdjacencyMatrix<String>()

let singapore = graph.createVertex(data: "Singapore")
let tokyo = graph.createVertex(data: "Tokyo")
let hongKong = graph.createVertex(data: "Hong Kong")
let detroit = graph.createVertex(data: "Detroit")
let sanFrancisco = graph.createVertex(data: "San Francisco")
let washingtonDC = graph.createVertex(data: "Washington DC")
let austinTexas = graph.createVertex(data: "Austin Texas")
let seattle = graph.createVertex(data: "Seattle")

graph.add(.undirected, from: singapore, to: hongKong, weight: 300)
graph.add(.undirected, from: singapore, to: tokyo, weight: 500)
graph.add(.undirected, from: hongKong, to: tokyo, weight: 250)
graph.add(.undirected, from: tokyo, to: detroit, weight: 450)
graph.add(.undirected, from: tokyo, to: washingtonDC, weight: 300)
graph.add(.undirected, from: hongKong, to: sanFrancisco, weight: 600)
graph.add(.undirected, from: detroit, to: austinTexas, weight: 50)
graph.add(.undirected, from: austinTexas, to: washingtonDC, weight: 292)
graph.add(.undirected, from: sanFrancisco, to: washingtonDC, weight: 337)
graph.add(.undirected, from: washingtonDC, to: seattle, weight: 277)
graph.add(.undirected, from: sanFrancisco, to: seattle, weight: 218)
graph.add(.undirected, from: austinTexas, to: sanFrancisco, weight: 297)

print(graph)