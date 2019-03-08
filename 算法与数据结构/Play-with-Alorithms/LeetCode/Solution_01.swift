//
//  File.swift
//  LeetCodeSolution
//
//  Created by WillHelen on 2018/8/16.
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
    
    // MARK: -------------- 搜索旋转排序数组 leetCode #33
    /*
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
    
    // MARK: -------------- 最大子序和 leetCode #53
    /*
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
    
    // MARK: -------------- 使用最小花费爬楼梯 leetCode #746
    /*
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
    
    // MARK: -------------- 二分查找 leetCode #704
    /*
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
    
    // MARK: -------------- 平衡二叉树 leetCode #110
    /*
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
    
    // MARK: -------------- 二叉树的最小深度 leetCode #111
    /*
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
    
    // MARK: -------------- 有效的括号 leetCode #20
    /*
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
     使用栈来解决：
     遍历字符串的每个字符，凡是遇到左括号，都入栈。
     如果遇到右括号，则与栈顶元素做匹配，如果匹配，则栈做pop操作，同时遍历到下一个字符
     如果不匹配，字符串不满足条件
     */
    func isBracketsBalances_stack(_ s : String) -> Bool {
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
        let stk = BasicStack<Character>()
        for c in s {
            if c == "{" || c == "(" || c == "[" {
                stk.push(c)
            } else {
                guard let top = stk.top() else {
                    return false
                }
                if isPair(top, c) {
                    return false
                }
                stk.pop()
            }
        }
        return stk.isEmpty()
    }

    // MARK: -------------- 比较含退格的字符串 leetCode #844
    /*
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
    
    // MARK: -------------- 移动零 leetCode #283
    /*
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
    
    // MARK: -------------- 移除元素 leetCode #27
    /*
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
    
    // MARK: -------------- 只出现一次的数字 leetCode #136
    /*
     https://leetcode-cn.com/problems/single-number/
     给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。找出那个只出现了一次的元素。
     说明：
     你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？
     
     示例 1:
     输入: [2,2,1]  输出: 1
     
     示例 2:
     输入: [4,1,2,1,2]  输出: 4
     */
    
    /*
     这道题最优的算法可以使时间复杂度为O(n), 空间复杂度为O(1)
     自己思考的解法，使用了额外得空间，复杂度为O(n) < k <= O(2n)
     */
    func singleNumber(_ nums: [Int]) -> Int {
        if nums.isEmpty {
            return -1
        }
        var countDic = [Int : Int]()
        for n in nums {
            if let count = countDic[n] {
                countDic[n] = count + 1
            } else {
                countDic[n] = 1
            }
        }
        var minCountNum = nums[0]
        for (key, value) in countDic {
            if value == 1 {
                minCountNum = key
                break
            }
        }
        return minCountNum
    }
    
    /*
     这道题如果想要使时间复杂度为O(n), 空间复杂度为O(1)的话，
     可以使用异或操作，异或操作的特性有一下几点：
     1. 相同数字异或结果为0，如果是二进制按位异或的话，相同为0，不同为1。
     2. 交换律： a ^ b = b ^ a
     3. 结合律： (a ^ b) ^ c = a ^ (b ^ c)
     4. 任何数和0异或结果都为本身 ： 0 ^ a = a
     由于题目说明数组中只有一个单独存在的数字，其他的都是成对出现的，
     所以可以将数组中的所有元素都做异或操作，根据交换律和结合律：
     a ^ b ^ a ^ b ^ c = (a ^ a) ^ (b ^ b) ^ c = 0 ^ 0 ^ c = c
     最后c就是那个只出现一次的元素。
     */
    func singleNumber_xor(_ nums: [Int]) -> Int {
        var res = 0
        for i in 0 ..< nums.count {
            res = res ^ nums[i]
        }
        return res
    }
    
    
    
    // MARK: -------------- 最接近原点的 K 个点 leetCode #973
    /*
     https://leetcode-cn.com/problems/k-closest-points-to-origin/
     我们有一个由平面上的点组成的列表 points。需要从中找出 K 个距离原点 (0, 0) 最近的点。
     （这里，平面上两点之间的距离是欧几里德距离。）
     你可以按任何顺序返回答案。除了点坐标的顺序之外，答案确保是唯一的。
     
     示例 1：
     输入：points = [[1,3],[-2,2]], K = 1  输出：[[-2,2]]
     解释：
     (1, 3) 和原点之间的距离为 sqrt(10)，
     (-2, 2) 和原点之间的距离为 sqrt(8)，
     由于 sqrt(8) < sqrt(10)，(-2, 2) 离原点更近。
     我们只需要距离原点最近的 K = 1 个点，所以答案就是 [[-2,2]]。
     
     示例 2：
     输入：points = [[3,3],[5,-1],[-2,4]], K = 2  输出：[[3,3],[-2,4]]
     （答案 [[-2,4],[3,3]] 也会被接受。）
     */
    
    /*
     其实就是求距离最近的k个元素，所以我们可以升序排列数组，然后取前K个元素
     */
    func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
        var points = points
        points.sort { (p1, p2) -> Bool in
            let d1 = p1[0] * p1[0] + p1[1] * p1[1]
            let d2 = p2[0] * p2[0] + p2[1] * p2[1]
            return d1 < d2
        }
        var res = [[Int]]()
        for i in 0 ..< K {
            res.append(points[i])
        }
        return res
    }
    
    //自己实现归并排序
    func kClosest_1(_ points: [[Int]], _ K: Int) -> [[Int]] {
        // 排序
        func mergeSort<T>(_ arr : [T], _ compare : (_ w : T, _ k : T) -> Bool) -> [T] {
            
            func _sort(_ l : Int, _ r : Int, _ a : inout[T], _ compare : (_ w : T, _ k : T) -> Bool) {
                if l >= r { return }
                let m = (r - l) / 2 + l
                _sort(l, m, &a, compare)
                _sort(m+1, r, &a, compare)
                _merge(l, m, r, &a, compare)
            }
            
            func _merge(_ l : Int, _ m : Int, _ r : Int, _ a : inout [T], _ compare : (_ w : T, _ k : T) -> Bool) {
                var i = l, j = m + 1, t = [T]()
                while i <= m && j <= r {
                    if compare(a[i],a[j]) { t.append(a[i]); i+=1 }
                    else { t.append(a[j]); j+=1 }
                }
                while i <= m { t.append(a[i]); i+=1 }
                while j <= r { t.append(a[j]); j+=1 }
                for i in 0 ..< t.count {
                    a[l+i] = t[i]
                }
            }
            var res = arr
            _sort(0, res.count-1, &res, compare)
            return res
        }
        
        let sortedPoints = mergeSort(points) { (p1, p2) -> Bool in
            let d1 = p1[0] * p1[0] + p1[1] * p1[1]
            let d2 = p2[0] * p2[0] + p2[1] * p2[1]
            return d1 < d2
        }
        var res = [[Int]]()
        for i in 0 ..< K {
            res.append(sortedPoints[i])
        }
        return res
    }
    
    // MARK: -------------- 求众数 leetCode #169
    /*
     https://leetcode-cn.com/problems/majority-element/
     给定一个大小为 n 的数组，找到其中的众数。众数是指在数组中出现次数大于 ⌊ n/2 ⌋ 的元素。
     你可以假设数组是非空的，并且给定的数组总是存在众数。
     
     示例 1:
     输入: [3,2,3]  输出: 3
     
     示例 2:
     输入: [2,2,1,1,1,2,2]  输出: 2
     */
    /*
     解法1：
     使用字典分别保存每个数字的出现次数，最后取出出现次数最多的那个数字。
     */
    func majorityElement(_ nums: [Int]) -> Int {
        var countMap = [Int : Int]()
        for n in nums {
            if let count = countMap[n] {
                countMap[n] = count + 1
            } else {
                countMap[n] = 1
            }
            let count = countMap[n]!
            if count > nums.count / 2{
                return n
            }
        }
        return -1
    }
    
    /*
     解法2: 分治法
     根据题意，数组中总会存在一个众数，所以可以把问题分解：
     1. 将数组分为左右两个子数组，取出左右两个子数组中的众数。
     2. 如果左边和右边的众数一样，那么直接返回这个众数。
     3. 如果左右两边的众数不一样，则返回在当前数组中出现次数最多的那个数。
     */
    func majorityElement_divideAndConquer(_ nums: [Int]) -> Int {
        
        func _partion(_ l : Int, _ r : Int) -> Int {
            
            if l >= r {
                return nums[l]
            }
            let m = (r - l) / 2 + l
            let lNum = _partion(l, m)
            let rNum = _partion(m+1, r)
            
            if lNum == rNum {
                return lNum
            }
            
            var lCnt = 0
            var rCnt = 0
            for i in l ... r {
                if nums[i] == lNum {
                    lCnt += 1
                }
                if nums[i] == rNum {
                    rCnt += 1
                }
            }
            return lCnt > rCnt ? lNum : rNum
        }
        let res = _partion(0, nums.count-1)
        return res
    }
    

    
    // MARK: -------------- 搜索二维矩阵 II leetCode #240
    /*
     https://leetcode-cn.com/problems/majority-element/
     编写一个高效的算法来搜索 m x n 矩阵 matrix 中的一个目标值 target。该矩阵具有以下特性：
     每行的元素从左到右升序排列。
     每列的元素从上到下升序排列。
     示例:
     现有矩阵 matrix 如下：
     [
     [1,   4,  7, 11, 15],
     [2,   5,  8, 12, 19],
     [3,   6,  9, 16, 22],
     [10, 13, 14, 17, 24],
     [18, 21, 23, 26, 30]
     ]
     给定 target = 5，返回 true。
     给定 target = 20，返回 false。
     */
    /*
     解法1. 动态规划：
     根据题意可以知道，针对每一个范围的矩阵左下角的数字v是这一列最大的，同时也是这一行最小的。
     所以可以将目标值t和左下角的值v进行比较：
     1. t 如果等于 v，则直接返回true
     2. t 如果大于 v，则目标值一定不会在v所处的这一列中，因为v已经是最大的了。
     3. t 如果小于 v，则目标值一定不会在v所处的这一行中，因为v已经是最下的了。
     就这样逐渐缩小范围，如果知道范围为0都没有找到，则返回false。
     */
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        var r = matrix.count-1, c = 0
        // 对于每一个矩阵，左下角的值都是这一列最大的，并且是这一行最小的
        while r >= 0 && c <= matrix[0].count - 1 {
            let v = matrix[r][c]
            if target == v {
                return true
        
            } else if target > v {
                // 如果目标值比左下角的还大，说明目标值一定不存在于这一列
                c += 1
                
            } else {
                // 如果目标值比左下角的值还小，说明目标值一定不存在于这一行
                r -= 1
            }
        }
        return false
    }
    
    /*
     解法2，二分搜索:
     首先取矩阵中的中央元素 v 与目标值 t 相比较：
     1. 如果目标值 t 小于 v， 则目标值应该存在于v 上边 或者 左边 的矩阵中。
     2. 如果目标值 t 小于 v， 则目标值应该存在于v 下边 或者 右边 的矩阵中。
     */
    func searchMatrix_binarySearch(_ matrix: [[Int]], _ target: Int) -> Bool {
        
        func _search(_ minX : Int, _ minY : Int, _ maxX : Int, _ maxY : Int) -> Bool {
            
            guard minX < maxX, minY < maxY else {
                return false
            }
            let midX = (maxX - minX) / 2 + minX
            let midY = (maxY - minY) / 2 + minY
            let mid  = matrix[midY][midX]
            if target == mid {
                return true
                
            } else if target < mid {
                // 在左边或者上边
                return _search(minX, minY, midX, maxY) || _search(minX, minY, maxX, midY)
                
            } else { // target >= mid
                // 在右边或者下面
                return _search(midX+1, minY, maxX, maxY) || _search(minX, midY+1, maxX, maxY)
            }
        }
        // 尾递归优化
        return _search(0, 0, matrix[0].count, matrix.count)
    }
    
    
    // MARK: -------------- 合并两个有序数组 leetCode #88
    /*
     https://leetcode-cn.com/problems/merge-sorted-array/
     给定两个有序整数数组 nums1 和 nums2，将 nums2 合并到 nums1 中，使得 num1 成为一个有序数组。
     说明:
     初始化 nums1 和 nums2 的元素数量分别为 m 和 n。
     你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。
     
     示例:
     输入:
     nums1 = [1,2,3,0,0,0], m = 3
     nums2 = [2,5,6],       n = 3
     输出: [1,2,2,3,5,6]
     
     nums1 = [1,2,4,5,0,0], m = 3
     nums2 = [1,3],       n = 3
     输出: [1,2,2,3,4,6]
     1 1 2 3
     
     */
    func merge_1(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        
        var res = [Int]()
        var i = 0, j = 0
        while i < m && j < n {
            if nums1[i] < nums2[j] {
                res.append(nums1[i])
                i += 1
            } else {
                res.append(nums2[j])
                j += 1
            }
        }
        while i < m {
            res.append(nums1[i])
            i += 1
        }
        while j < n {
            res.append(nums2[j])
            j += 1
        }
        nums1 = res
    }
    
    func merge_2(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var k = m + n
        var i = m , j = n
        while i > 0 && j > 0 {
            if nums1[i-1] > nums2[j-1]  {
                nums1[k-1] = nums1[i-1]
                i -= 1
                
            } else {
                nums1[k-1] = nums2[j-1]
                j -= 1
            }
            k -= 1
        }
        
        while j > 0 {
            nums1[k-1] = nums2[j-1]
            k -= 1
            j -= 1
        }
    }
    
    func merge_3(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var i = m, j = 0
        while j < n {
            nums1[i] = nums2[j]
            j += 1
            i += 1
        }
        nums1.sort()
    }
    
    // MARK: -------------- 验证回文串 leetCode #125
    /*
     https://leetcode-cn.com/problems/valid-palindrome/
     给定一个字符串，验证它是否是回文串，只考虑字母和数字字符，可以忽略字母的大小写。
     说明：本题中，我们将空字符串定义为有效的回文串。
     
     示例 1:
     输入: "A man, a plan, a canal: Panama"
     输出: true
     
     示例 2:
     输入: "race a car"
     输出: false
     */
    func isPalindrome(_ s: String) -> Bool {
        func isValid(_ i : Int, _ s : String) -> Bool {
            let c = s.charAt(i)
            return c.isChar() || c.isNum()
        }
        let s = s.lowercased()
        var i = 0, j = s.count-1
        while true {
            while i <= j && !isValid(i,s) {
                i += 1
            }
            while i <= j && !isValid(j,s) {
                j -= 1
            }
            
            if i > j {
                break
            }
            
            if s.charAt(i) == s.charAt(j) {
                i += 1
                j -= 1
            } else {
                return false
            }
        }
        return true
    }
    
    func isPalindrome_sysApi(_ s: String) -> Bool {
        
        func isValid(_ c : Character) -> Bool {
            return c.isChar() || c.isNum()
        }
        let s = s.lowercased()
        var newStr = ""
        for c in s {
            if isValid(c) {
                newStr.append(c)
            }
        }
        return newStr.reversed().elementsEqual(newStr)
    }
    
    
    // MARK: -------------- 分割回文串 leetCode #131
    /*
     https://leetcode-cn.com/problems/palindrome-partitioning/
     给定一个字符串 s，将 s 分割成一些子串，使每个子串都是回文串。 返回 s 所有可能的分割方案。
     
     示例:
     输入: "aab"
     输出:
     [
        ["aa","b"],
        ["a","a","b"]
     ]
     */
    
    /*
     由于是求全集的问题，所以可以使用回溯法来解决该问题。
     首先要明确的是，分割回文字符串的操作可以针对任何一个子字符串，所以可以用 深度优先搜索 + 回溯剪枝 来解决。
     提供一个动态索引，当索引位置在字符串中i的位置时：
     1. 如果左边的字符串是回文，则加到结果集里面，那么再看右边的字符串该如何分割，这又是一个子问题（递归）。
     2. 如果不是回文，则说明以i这个位置分割的字符串结果集不是有效的，所以索引位置向后移动一位。
     当某一个递归子问题处理的字符串的长度小于1的时候，说明深度优先遍历走到尽头，
     此时结果集里面已经保存了一种分割方案了，将该方案添加到最终的结果数组中。
     当前路径已经走完，所以需要回溯到父节点走另一条分支，回溯的过程中需要将走过的结点删除掉。
     */
    func partition(_ s: String) -> [[String]] {
        
        func isPalindrome(_ s : String, _ l : Int, _ r : Int) -> Bool {
            if l == r || s.isEmpty { return true }
            var i = l, j = r
            while l <= j {
                if s.charAt(i) != s.charAt(j) {
                    return false
                }
                i += 1; j -= 1
            }
            return true
        }
        
        func _dfs(s : String, res : inout [String], final : inout [[String]]) {
            if s.count < 1 {
                final.append(Array(res))
                return
            }
            for i in 1 ... s.count {
                let strLeft = s.substringInRange((0 ..< i))!
                if isPalindrome(s, 0, strLeft.count-1) {
                    res.append(strLeft)
                    let strRight = s.substringInRange((i ..< s.count)) ?? ""
                    _dfs(s: strRight, res: &res, final: &final)
                    // 回溯
                    res.removeLast()
                }
            }
        }
        
        var temp = [String]()
        var res = [[String]]()
        _dfs(s: s, res: &temp, final: &res)
        return res
    }
    
    // MARK: -------------- 单词拆分 leetCode #139
    /*
     https://leetcode-cn.com/problems/word-break/
     给定一个非空字符串 s 和一个包含非空单词列表的字典 wordDict，判定 s 是否可以被空格拆分为一个或多个在字典中出现的单词。
     
     说明：
     拆分时可以重复使用字典中的单词。 你可以假设字典中没有重复的单词。
     
     示例 1：
     输入: s = "leetcode", wordDict = ["leet", "code"]   输出: true
     解释: 返回 true 因为 "leetcode" 可以被拆分成 "leet code"。
     
     示例 2：
     输入: s = "applepenapple", wordDict = ["apple", "pen"]  输出: true
     解释: 返回 true 因为 "applepenapple" 可以被拆分成 "apple pen apple"。
     注意你可以重复使用字典中的单词。
     
     示例 3：
     输入: s = "catsandog", wordDict = ["cats", "dog", "sand", "and", "cat"]  输出: false
     */
    /*
     由于递归解法会造成超时，所以使用非递归的形式尝试解决。
     还是动态优化的思路，假设有一个数组dp，
     dp[i]用来标识字符串中 i 前面的子字符串是否可以被wordDict中的单词完美划分出来。
     那么dp[i]为true的条件就是：
     1. 存在一个e位置 j(j < i), 并且j前面的字符串是可以被完美划分的，即dp[j] == true
     2. j 后面的字符串在 wordDict 中可以找到。
     满足上面两个条件的话，就可以说明位置i之前的字符串是可以被完美划分的，
     即 dp[j] = true && wordDict.contain(s.substring([j ..< i]))
     那么如果 k = s.length, dp[k] == true的话，就说明整个字符串都可以被完美划分。
     
     【注意】
     之前一直有疑问，dp[0]的初始值为什么是true而不是false？
     我们可以看一下这个例子：
     let s = "catssanddog"
     let wordDict = ["cats", "dog", "sand", "and", "cat"]
     
     当i走到4的时候，我们知道dp[4]其实是true
     那么此时当j为0时，我们需要使dp[4]为true，
     也就是表达式 dp[0] == true && wordDict.contains(s[0 ..< 4])
     我们知道 wordDict.contains(s[0 ..< 4]) 肯定为true了，
     那么如果dp[0]为false的话会使表达式结果为false，
     因此如果dp[0]初始值为false的话，会影响本该正确的条件判断。
     */
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        
        if s.isEmpty {
            return false
        }
        var dp = Array(repeating: false, count: s.count+1)
        dp[0] = true
        for i in 0 ... s.count {
            for j in 0 ..< i {
                let subString = s.substringInRange((j..<i))!
                if dp[j] == true && wordDict.contains(subString) {
                    dp[i] = true
                    break
                }
            }
        }
        return dp[s.count]
    }
    
    /*
     动态规划的递归形式，会超时，待优化。
     如何优化可以参考：https://blog.csdn.net/bw_yyziq/article/details/79825543
     */
    func wordBreak_1(_ s: String, _ wordDict: [String]) -> Bool {
        
        func _dfs(s : String, dic : inout [String]) -> Bool {
            if s.count < 1 {
                return true
            }
            for i in 1 ... s.count {
                guard let prefix = s.substringInRange((0 ..< i)) else {
                    return false
                }
                if dic.contains(prefix) {
                    let surfix = s.substringInRange((i..<s.count)) ?? ""
                    if _dfs(s: surfix, dic: &dic) {
                        return true
                    }
                }
            }
            return false
        }
        var dic = wordDict
        return _dfs(s: s, dic: &dic)
    }
}



