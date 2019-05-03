// public class TreeNode {
//     public var val: Int
//     public var left: TreeNode?
//     public var right: TreeNode?
//     public init(_ val: Int) {
//         self.val = val
//         self.left = nil
//         self.right = nil
//     }
// }

class Solution {
    func findSecondMinimumValue(_ root: TreeNode?) -> Int {
        guard let root = root else { return -1 }
        
        return findSecond(root: root, minimum: root.val)
    }
    
    func findSecond(root: TreeNode, minimum: Int) -> Int {
        if root.val > minimum { return root.val }
        
        if let left = root.left, let right = root.right {
            let l = findSecond(root: left, minimum: minimum)
            let r = findSecond(root: right, minimum: minimum)
            
            let maxV = max(l, r)
            let minV = min(l, r)
            
            if minV > minimum {
                return minV
            } else if maxV > minimum {
                return maxV
            }
        }
        
        return -1
    }
}
//Runtime: 4 ms, faster than 100.00% of Swift online submissions for Second Minimum Node In a Binary Tree.
//Memory Usage: 18.7 MB, less than 75.00% of Swift online submissions for Second Minimum Node In a Binary Tree.
