# https://leetcode-cn.com/problems/triangle/

#给定一个三角形 triangle ，找出自顶向下的最小路径和。
#每一步只能移动到下一行中相邻的结点上。相邻的结点 在这里指的是 下标 与 上一层结点下标 相同或者等于 上一层结点下标 + 1 的两个结点。也就是说，如果正位于当前行的下标 i ，那么下一步可以移动到下一行的下标 i 或 i + 1 。

class Solution:
    def minimumTotal(self, triangle: List[List[int]]) -> int:
        return self.divide_conquer(triangle, 0, 0, {})

    def divide_conquer(self, triangle, x, y, memo):
        if x == len(triangle):
            return 0
        
        if (x, y) in memo:
            return memo[(x, y)]
        
        left = self.divide_conquer(triangle, x + 1, y, memo)
        right = self.divide_conquer(triangle, x + 1, y + 1, memo)
        
        memo[(x, y)] = min(left, right) + triangle[x][y]
        return memo[(x, y)]