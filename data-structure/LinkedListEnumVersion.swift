indirect enum List<Element> {
	case empty
	case cons(Element, List)
}

let list: List<Int> = .cons(1, .cons(2, .cons(3, .empty)))
dump(list)

extension List {
	func fold<Result>(_ emptyCase: Result, _ conCase: (Element, Result) -> Result) -> Result {
		switch self {
		case .empty:
			return emptyCase
		case let .cons(x, xs):
			return conCase(x, xs.fold(emptyCase, conCase))
		}
	}
	
	func reduce<Result>(_ emptyCase: Result, _ consCase: (Element, Result) -> Result) -> Result {
		let result = emptyCase
		switch self {
		case .empty:
			return result
		case let .cons(x, xs):
			return xs.reduce(consCase(x, result), consCase)
		}
	}
}

let r = list.fold(0, +)
let t = list.fold(0, { _, result in result + 1})
print(r)
print(t)

dump(list.fold(List.empty, List.cons))
dump(Array(1...3).reduce(List.empty, { .cons($1, $0)}))
dump(list.reduce(List.empty, List.cons))
