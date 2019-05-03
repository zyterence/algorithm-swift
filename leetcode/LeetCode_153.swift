class Solution {
    func findMin(_ nums: [Int]) -> Int {
        for number in nums {
            if number < nums[0] { return number }
        }
        return nums[0]
    }
}

// too simple