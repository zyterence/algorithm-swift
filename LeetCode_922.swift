class Solution {
    func sortArrayByParityII(_ A: [Int]) -> [Int] {
        var result = A
        var evenIndex = 0
        var oddIndex = 1
        
        for index in 0..<A.count {
            if A[index] % 2 == 0 {
                result[evenIndex] = A[index]
                evenIndex = evenIndex + 2
            } else {
                result[oddIndex] = A[index]
                oddIndex = oddIndex + 2
            }
        }
        
        return result
    }
}

// Runtime: 196 ms, faster than 99.24% of Swift online submissions for Sort Array By Parity II.
// Memory Usage: 20 MB, less than 5.26% of Swift online submissions for Sort Array By Parity II.


// solution 2 by JavaScript
var sortArrayByParityII = function(A) {
    var j = 1;
    for (var i=0, j=1; i<A.length; i+=2)
        if (A[i] % 2 == 1) {
            while (A[j] % 2 == 1) j += 2;
            [A[i], A[j]] = [A[j], A[i]]
        }
    return A;
};
// Runtime: 120 ms, faster than 50.18% of JavaScript online submissions for Sort Array By Parity II.
// Memory Usage: 38.2 MB, less than 98.85% of JavaScript online submissions for Sort Array By Parity II.