//
//  File.swift
//  LeetCodeSolution
//
//  Created by 朱金倩 on 2018/8/16.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

extension Solution {
    
    /*
     已知有很多会议，如果这些会议的时间有重叠，则将他们合并
     例：
     输入：[[1,2], [3,4]], 输出 : [[1,2], [3,4]]
     解释：[1,2] 和 [3,4]之间没有重叠，所以按原样输出
     
     输入：[[1,3], [2,4]], 输出 : [[1,4]]
     解释：[1,3] 和 [2,4]之间有重叠，所以输出合并后的[[1,4]]
     
     输入：[[1,5], [2,4]], 输出 : [[1,5]]
     解释：[1,5] 包含了 [2,4]之间有重叠，所以输出合并后的[[1,5]]
     
     假设输入的数组只有两个元素，切a[0]是开始时间，a[1]是结束时间
     */
    
    func mergeMeetings(_ mettings : [[Int]]) -> [[Int]] {
        
        if mettings.isEmpty {
            return []
        }
        
        func start(_ t : [Int]) -> Int {
            return t[0]
        }
        func end(_ t : [Int]) -> Int {
            return t[1]
        }
        
        func setEnd(_ a : inout [Int], time : Int) {
            a[1] = time
        }
        
        var mettings = mettings
        //首先应该将有可能重叠的时间尽量放在一起，那么就需要优先升序排列起始时间，然后再按结束时间排序
        mettings.sort { (m1, m2) -> Bool in
            if start(m1) != start(m2) {
                return start(m1) < start(m2)
            } else {
                return end(m1) < end(m2)
            }
        }
        
        var res = [[Int]]()
        res.append([ start(mettings[0]), end(mettings[0]) ])
        
        for i in 1 ..< mettings.count {
            let curr = mettings[i]
            let last = res.last!
            //当前的时间和上一个时间段比较
            if end(last) < start(curr) {
                //如果时间不重叠（没有交集）,则添加进结果数组
                res.append([start(curr), end(curr)])
            } else {
                setEnd(&res[res.count-1], time: max(end(last), end(curr)))
            }
        }
        
        return res
    }
    
    /*
     leetCode #33
     https://leetcode-cn.com/problems/search-in-rotated-sorted-array/description/
     假设按照升序排序的数组在预先未知的某个点上进行了旋转。
     ( 例如，数组 [0,1,2,4,5,6,7] 可能变为 [4,5,6,7,0,1,2] )。
     搜索一个给定的目标值，如果数组中存在这个目标值，则返回它的索引，否则返回 -1 。 你可以假设数组中不存在重复的元素。
     你的算法时间复杂度必须是 O(log n) 级别。
     
     示例 1:
     输入: nums = [4,5,6,7,0,1,2], target = 0
     输出: 4
     示例 2:
     
     输入: nums = [4,5,6,7,0,1,2], target = 3
     输出: -1
     */
    /*
     有两种情况：
     1.旋转的位置比较靠左边，那么旋转之后，mid左边的是有序的，右边是无序的
     2.旋转的位置比较靠右边，那么旋转之后，mid右边的是有序的，左边是无序的
     这是需要看target的值：
     1.target 大于 mid：
       如果是情况1，那么对左边无序的子数组重新查找。
       如果是情况2，那么对右边有序的子数组进行二分查找。
     2.target 小于 mid：
       如果是情况1，那么对左边有序的子数组进行二分查找。
       如果是情况2，那么对右边无序的子数组重新查找。
     */
    func searchInRotatedArray(_ nums: [Int], _ target: Int) -> Int {
        
        var left = 0
        var right = nums.count - 1
        var mid = 0
        
        while left <= right {
            mid = (right - left) / 2 + left
            if nums[mid] == target {
                return mid
            }
            //mid 和 left比较，mid >= left,左边有序，反之右边有序
            if nums[mid] >= nums[left] {
                if target >= nums[left] && target <= nums[mid] {
                    right = mid - 1
                } else {
                    left = mid + 1
                }
            } else {
                if target >= nums[mid] && target <= nums[right] {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
        }
        return -1
    }
    
    
    /*
     leetCode #53
     https://leetcode-cn.com/problems/maximum-subarray/description/
     给定一个整数数组 nums ，找到一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。
     示例:
     输入: [-2,1,-3,4,-1,2,1,-5,4],
     输出: 6
     解释: 连续子数组 [4,-1,2,1] 的和最大，为 6。
     参考：https://www.cnblogs.com/coderJiebao/p/Algorithmofnotes27.html

     解法：（分治法 or 动态规划）
     步骤 1：令状态 dp[i] 表示以 A[i] 作为末尾的连续序列的最大和（这里是说 A[i] 必须作为连续序列的末尾）。
     步骤 2：做如下考虑：因为 dp[i] 要求是必须以 A[i] 结尾的连续序列，那么只有两种情况：
     这个最大和的连续序列只有一个元素，即以 A[i] 开始，以 A[i] 结尾。
     这个最大和的连续序列有多个元素，即从前面某处 A[p] 开始 (p<i)，一直到 A[i] 结尾。
     　　　　对第一种情况，最大和就是 A[i] 本身。
     　　　　对第二种情况，最大和是 dp[i-1]+A[i]。
     　　　　于是得到状态转移方程： dp[i] = max(A[i], dp[i-1]+A[i])
     这个式子只和 i 与 i 之前的元素有关，且边界为 dp[0] = A[0]，
     由此从小到大枚举 i，即可得到整个 dp 数组。
     接着输出 dp[0]，dp[1]，...，dp[n-1] 中的最大子即为最大连续子序列的和。
     */
    func maxSubArray(_ nums: [Int]) -> Int {
        
        if nums.isEmpty {
            return 0
        }
        //动态规划，已经计算的不需要再算了
        var cache = Array(repeating: Int.min, count: nums.count)
        func _dp(_ a : [Int], _ index : Int) -> Int {
            if index == 0 {
                cache[0] = a[0]
                return a[0]
            }
            if cache[index] != Int.min {
                return cache[index]
            }
            cache[index] = max(a[index], _dp(a, index-1) + a[index])
            return cache[index]
        }
        
        var dp_max = Int.min
        for i in 0 ..< nums.count {
            let dp = _dp(nums, i)
            if dp >= dp_max {
                dp_max = dp
            }
        }
        return dp_max
    }
    
    func maxSubArray1(_ nums: [Int]) -> Int {
        
        let len = nums.count
        var dp : [Int] = Array(repeating: Int.min, count: len)
        dp[0] = nums[0]
        dp[1] = max(nums[0], nums[1])
        
        for i in 2 ..< len {
            dp[i] = max(dp[i-1] + nums[i], nums[i])
        }
        
        var res_max = Int.max
        for item in dp {
            res_max = item > res_max ? item : res_max
        }
        
        return res_max
    }
    
    
    /*
     leetCode #746
     https://leetcode-cn.com/problems/min-cost-climbing-stairs/description/
     数组的每个索引做为一个阶梯，第 i个阶梯对应着一个非负数的体力花费值 cost[i](索引从0开始)。
     每当你爬上一个阶梯你都要花费对应的体力花费值，然后你可以选择继续爬一个阶梯或者爬两个阶梯。
     您需要找到达到楼层顶部的最低花费。在开始时，你可以选择从索引为 0 或 1 的元素作为初始阶梯。
     
     示例 1:
     输入: cost = [10, 15, 20]
     输出: 15
     解释: 最低花费是从cost[1]开始，然后走两步即可到阶梯顶，一共花费15。
     
     示例 2:
     输入: cost = [1, 100, 1, 1, 1, 100, 1, 1, 100, 1]
     输出: 6
     解释: 最低花费方式是从cost[0]开始，逐个经过那些1，跳过cost[3]，一共花费6。
     */
    /*
     在分析的时候要加上楼顶，既然到达楼顶就是最终目的，那不妨设楼顶的花费为0，像下面一样分析：
     零个台阶：0
     一个台阶：1,0
     两个台阶：1,100,0
     三个台阶：1,100,1,0
     。。。
     
     所以dp[0]=0；
     由于一次可以迈两步，可以直接从越过一个台阶直接到楼顶，dp[1]也等于0
     下面是分析一个台阶以上的情况。设i是某阶台阶（包括楼顶）
     四个台阶： 1,100,1,1,0
     由于一次最多迈两步，我可以从第四个台阶迈到楼顶，也可以从第三个迈过去
     对于第四，第三个台阶的花费是确定的，分别为 cost[3] 与 cost [2]，
     第四，第三个台阶之前的最小花费分别是dp[3]与dp[2]
     （别忘了dp[0]是零个台阶的花费，所以第四个台阶之前的最小花费应该是dp[3]）
     所以对于到楼顶，有如下两种选择：
     到达倒数第一个台阶最小花费+本身花费，即cost[3]+dp[3]+0；
     到达倒数第二个台阶最小花费+本身花费，即cost[2]+dp[2]+0
     选择其中最小的一个
     推而广之，到达第n(n>2)个台阶最小花费dp[n]=min(dp[n-2]+cost[n-2],dp[n-1]+cost[n-1]);
     https://blog.csdn.net/qq_40636117/article/details/81475680
     */
    func minCostClimbingStairs(_ cost: [Int]) -> Int {
        let len = cost.count
        var dp : [Int] = Array(repeating: Int.max, count: len+1)
        dp[0] = 0
        dp[1] = 0
        
        for i in 2 ... len {
            dp[i] = min(dp[i-1] + cost[i-1], dp[i-2] + cost[i-2])
        }
        return dp[len]
    }
    
    /*
     leetCode #704
     https://leetcode-cn.com/problems/binary-search/description/
     二分查找
     */
    func binarySearch(_ nums: [Int], _ target: Int) -> Int {
        var left = 0, right = nums.count-1
        var mid = 0
        while left <= right {
            mid = (right - left) / 2 + left
            if nums[mid] == target {
                return mid
            } else if target < nums[mid] {
                right = mid - 1
            } else {
                left = mid + 1
            }
        }
        return -1
    }
    
    /*
     leetCode #110
     https://leetcode-cn.com/problems/balanced-binary-tree/description/
     给定一个二叉树，判断它是否是高度平衡的二叉树。 本题中，一棵高度平衡二叉树定义为：
     一个二叉树每个节点 的左右两个子树的高度差的绝对值不超过1。
     示例 1:
     给定二叉树 [3,9,20,null,null,15,7]   返回 true 。
         3
        / \
       9   20
      / \
     15  7
     
     示例 2:
     给定二叉树 [1,2,2,3,3,null,null,4,4]   返回 false 。
     
           1
          / \
         2   2
        / \
       3   3
      / \
     4   4
    */
    func isBalanced(_ root: TreeNode<Int>?) -> Bool {
        
        func _depth(_ node : TreeNode<Int>?) -> Int {
            if node == nil { return 0 }
            return max(_depth(node?.left), _depth(node?.right)) + 1
        }
        
        func _isBalanced(_ node : TreeNode<Int>?) -> Bool {
            if node == nil {
                return true
            }
            if abs(_depth(node?.left) - _depth(node?.right)) > 1 {
                return false
            }
            return _isBalanced(node?.left) && _isBalanced(node?.right)
        }
        return _isBalanced(root)
    }
    
    /*
     leetCode #111
     https://leetcode-cn.com/problems/minimum-depth-of-binary-tree/description/
     给定一个二叉树，找出其最小深度。 最小深度是从根节点到最近叶子节点的最短路径上的节点数量。
     说明: 叶子节点是指没有子节点的节点。
     
     示例:
     给定二叉树 [3,9,20,null,null,15,7], 返回它的最小深度  2.
          3
         / \
        9  20
       / \
      15  7
     */
    func minDepth(_ root: TreeNode<Int>?) -> Int {
        func _depth(_ n : TreeNode<Int>?) -> Int {
            if n == nil {
                return 0
            }
            return min(_depth(n?.left), _depth(n?.right)) + 1
        }
        if root == nil {
            return 0
        }
        if root?.left == nil && root?.right == nil {
            return 1
        } else if root?.left == nil {
            return _depth(root?.right) + 1
        } else if root?.right == nil {
            return _depth(root?.left) + 1
        } else {
            return _depth(root)
        }
    }
    /*
     leetCode #20
     https://leetcode-cn.com/problems/valid-parentheses/description/
     给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。
     有效字符串需满足：
     左括号必须用相同类型的右括号闭合。 左括号必须以正确的顺序闭合。 注意空字符串可被认为是有效字符串。
     
     示例 1:
     输入: "()"  输出: true
     
     示例 2:
     输入: "()[]{}"  输出: true
     
     示例 3:
     输入: "(]"  输出: false
     
     示例 4:
     输入: "([)]"  输出: false
     
     示例 5:
     输入: "{[]}"  输出: true
     */
    func isBracketsBalances(_ s : String) -> Bool {
        
        func isPair(_ l : Character, _ r : Character) -> Bool {
            switch l {
            case "(": return r == ")"
            case "[": return r == "]"
            case "{": return r == "}"
            default : return false
            }
        }
        if s.isEmpty {
            return true
        }
        var lArr = [Character]()
        for c in s {
            if c == "{" || c == "(" || c == "[" {
                lArr.append(c)
            }
            
            if c == "}" || c == ")" || c == "]" {
                if lArr.isEmpty {
                    return false
                }
                let c_last = lArr.last!
                if isPair(c_last, c) {
                    lArr.removeLast()
                } else {
                    return false
                }
            }
        }
        return lArr.isEmpty
    }

    /*
     leetCode #844
     https://leetcode-cn.com/problems/backspace-string-compare/description/
     给定 S 和 T 两个字符串，当它们分别被输入到空白的文本编辑器后，判断二者是否相等，并返回结果。 # 代表退格字符。
     示例 1：
     输入：S = "ab#c", T = "ad#c"
     输出：true
     解释：S 和 T 都会变成 “ac”。
     
     示例 2：
     输入：S = "ab##", T = "c#d#"
     输出：true
     解释：S 和 T 都会变成 “”。
     
     示例 3：
     输入：S = "a##c", T = "#a#c"
     输出：true
     解释：S 和 T 都会变成 “c”。
     
     示例 4：
     输入：S = "a#c", T = "b"
     输出：false
     解释：S 会变成 “c”，但 T 仍然是 “b”。
     */
    func backspaceCompare(_ S: String, _ T: String) -> Bool {
        var arr_s = [Character]()
        var arr_t = [Character]()
        
        for c in S {
            if c == "#" {
                if !arr_s.isEmpty {
                    arr_s.removeLast()
                }
            } else {
                arr_s.append(c)
            }
        }
        for c in T {
            if c == "#" {
                if !arr_t.isEmpty {
                    arr_t.removeLast()
                }
            } else {
                arr_t.append(c)
            }
        }
        
        if arr_s.count != arr_t.count {
            return false
        }
        
        for i in 0 ..< arr_s.count {
            if arr_s[i] != arr_t[i] {
                return false
            }
        }
        return true
    }
    
    /*
     leetCode #283
     https://leetcode-cn.com/problems/move-zeroes/description/
     给定一个数组 nums，编写一个函数将所有 0 移动到数组的末尾，同时保持非零元素的相对顺序。
     示例:
     输入: [0,1,0,3,12]  输出: [1,3,12,0,0]
     
     说明:
     必须在原数组上操作，不能拷贝额外的数组。
     尽量减少操作次数。
     */
    func moveZeroes(_ nums: inout [Int]) {
        var i = 0
        var last = 0
        while i <= nums.count - last - 1 {
            if nums[i] == 0 {
                for z in i ..< nums.count - last - 1 {
                    nums.swapAt(z, z+1)
                }
                last += 1
            } else {
                i += 1
            }
        }
    }
    
    /*
     leetCode #27
     https://leetcode-cn.com/problems/remove-element/description/
     给定一个数组 nums 和一个值 val，你需要原地移除所有数值等于 val 的元素，返回移除后数组的新长度。
     不要使用额外的数组空间，你必须在原地修改输入数组并在使用 O(1) 额外空间的条件下完成。
     元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。
     
     示例 1:
     给定 nums = [3,2,2,3], val = 3,
     函数应该返回新的长度 2, 并且 nums 中的前两个元素均为 2。
     你不需要考虑数组中超出新长度后面的元素。
     
     示例 2:
     给定 nums = [0,1,2,2,3,0,4,2], val = 2,
     函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0, 4。
     注意这五个元素可为任意顺序。
    
     你不需要考虑数组中超出新长度后面的元素。
     */
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        
        var i = 0
        var last = 0
        while i < nums.count - last {
            if nums[i] == val {
                for z in i ..< nums.count - last - 1 {
                    nums.swapAt(z, z+1)
                }
                last += 1
            } else {
                i += 1
            }
        }
        return nums.count - last
    }
}
