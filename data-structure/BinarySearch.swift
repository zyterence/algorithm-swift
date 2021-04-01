func binarySearch(_ nums: [Int], _ target: Int) -> Bool {
	var left = 0, mid = 0, right = nums.count - 1
	
	while left <= right {
		mid = (right - left) / 2 + left
		if nums[mid] == target {
			return true
		} else if nums[mid] < target {
			left = mid + 1
		} else {
			right = mid - 1
		}
	}
	
	return false
}


let r1 = binarySearch([3,2,4,8], 5)
print(r1)

let r2 = binarySearch([3,2,4,8], 4)
print(r2)