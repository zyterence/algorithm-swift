class Solution {
	func sortArrayByParity(_ A: [Int]) -> [Int] {
		var even = [Int]()
		var odd = [Int]()

        for number in A {
            if number % 2 == 0 {
				even.append(number)
			} else {
				odd.append(number)
			}
        }
			
		return even+odd
	}
}

// 使用注释中的 forEach 代码的运行时间是 92 ms
// 而使用 for in 的运行时间只有 72 ms
// Runtime: 72 ms, faster than 93.41% of Swift online submissions for Sort Array By Parity.
// Memory Usage: 19.4 MB, less than 12.50% of Swift online submissions for Sort Array By Parity.


// solution 2 by JavaScript
var sortArrayByParity = function(A) {
    for (var i=0, j=A.length-1; i<j; i++, j--) {
        while (A[i]%2 == 0) if (i>=j) break; else i++;
        while (A[j]%2 == 1) if (i>=j) break; else j--;
        [A[i], A[j]] = [A[j], A[i]];
    }
    return A;
};

// Runtime: 84 ms, faster than 93.15% of JavaScript online submissions for Sort Array By Parity.
// Memory Usage: 37.3 MB, less than 40.08% of JavaScript online submissions for Sort Array By Parity.