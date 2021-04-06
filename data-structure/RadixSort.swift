extension Array where Element == Int {
	
	public mutating func radixSort() {
		let base = 10
		var done = false
		var digits = 1
		while !done {
			var buckets: [[Int]] = .init(repeating: [], count: base)
			forEach {
				number in
				let remainingPart = number / digits
				let digit = remainingPart % base
				buckets[digit].append(number)
				if remainingPart > 0 {
					done = false
				}
			}
			digits *= base
			self = buckets.flatMap { $0 }
		}
	}
}

func example(of title: String, excute: ()->()) {
	print("---Example of \(title)---")
	excute()
}


example(of: "radix sort") {
	var array = [88, 410, 1772, 20]
	print("Original array: \(array)")
	array.radixSort()
	print("Radix sorted: \(array)")
}

