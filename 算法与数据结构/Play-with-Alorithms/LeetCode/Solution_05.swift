//
//  Solution_05.swift
//  Play-with-Alorithms
//
//  Created by 郑毅 on 2019/2/14.
//  Copyright © 2019 ZhengYi. All rights reserved.
//

import Foundation


extension Solution {

    // MARK: -------------- 岛屿的个数 leetCode #200
    /*
     https://leetcode-cn.com/problems/number-of-islands/
     给定一个由 '1'（陆地）和 '0'（水）组成的的二维网格，计算岛屿的数量。一个岛被水包围，
     并且它是通过水平方向或垂直方向上相邻的陆地连接而成的。你可以假设网格的四个边均被水包围。
     
     示例 1, 输入:
     1 1 1 1 0
     1 1 0 1 0
     1 1 0 0 0
     0 0 0 0 0    输出: 1
     
     示例 2, 输入:
     1 1 0 0 0
     1 1 0 0 0
     0 0 1 0 0
     0 0 0 1 1    输出: 3
     
     解法：
     遍历grid数组，如果遇到1，则说明遇到了一个岛屿，那么通过深度优先搜索dfs将与其相连的陆地都设置为0（像是扫雷一样）
     在遍历结束之前如果又遇到了1，则说明还有一个岛屿，重复上述操作。
     */
    func numIslands(_ grid: [[Character]]) -> Int {
        
        var grid = grid
        if grid.isEmpty || grid[0].isEmpty {
            return 0
        }
        var visited : [[Bool]] = Array(repeating: Array(repeating: false, count: grid[0].count), count: grid.count)
        func dfs(row : Int, colum : Int) {
            
            if grid.isEmpty || grid[0].isEmpty {
                return
            }
            
            if row < 0 || row >= grid.count || colum < 0 || colum >= grid[0].count {
                return
            }
            
            if visited[row][colum] {
                return
            }
            
            if grid[row][colum] == "0" {
                visited[row][colum] = true
                return
            }
            
            if grid[row][colum] == "1" {
                //将 grid[row][colum] 上下左右的位置都设置为 0
                grid[row][colum] = "0"
                visited[row][colum] = true
                dfs(row: row+1, colum: colum)
                dfs(row: row-1, colum: colum)
                dfs(row: row  , colum: colum+1)
                dfs(row: row  , colum: colum-1)
            }
        }
        
        var count = 0
        for i in 0 ..< grid.count {
            for j in 0 ..< grid[0].count {
                // 如果遇到1，则说明遇到了一个岛屿
                if grid[i][j] == "1" {
                    // 深度优先遍历将与 grid[i][j] 相连的陆地都设置为0
                    // 得到了一个岛屿，统计之后将其除掉，方便下次遍历
                    dfs(row: i, colum: j)
                    count += 1
                }
            }
        }
        return count
    }
    
    // MARK: -------------- 打开转盘锁 leetCode #752
    /*
     https://leetcode-cn.com/problems/open-the-lock/comments/
     你有一个带有四个圆形拨轮的转盘锁。每个拨轮都有10个数字：
     '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' 。
     每个拨轮可以自由旋转：例如把 '9' 变为  '0'，'0' 变为 '9' 。每次旋转都只能旋转一个拨轮的一位数字。
     
     锁的初始数字为 '0000' ，一个代表四个拨轮的数字的字符串。
     列表 deadends 包含了一组死亡数字，一旦拨轮的数字和列表里的任何一个元素相同，这个锁将会被永久锁定，无法再被旋转。
     字符串 target 代表可以解锁的数字，你需要给出最小的旋转次数，如果无论如何不能解锁，返回 -1。
     
     示例 1:
     输入: deadends = ["0201","0101","0102","1212","2002"], target = "0202"  输出：6
     解释:
     可能的移动序列为 "0000" -> "1000" -> "1100" -> "1200" -> "1201" -> "1202" -> "0202"。
     注意 "0000" -> "0001" -> "0002" -> "0102" -> "0202" 这样的序列是不能解锁的，
     因为当拨动到 "0102" 时这个锁就会被锁定。
     
     示例 2:
     输入: deadends = ["8888"], target = "0009"  输出：1
     解释: 把最后一位反向旋转一次即可 "0000" -> "0009"。
     
     示例 3:
     输入: deadends = ["8887","8889","8878","8898","8788","8988","7888","9888"], target = "8888"
     输出：-1
     解释： 无法旋转到目标数字且不被锁定。
     
     示例 4:
     输入: deadends = ["0000"], target = "8888"
     输出：-1
     
     提示：
     死亡列表 deadends 的长度范围为 [1, 500]。
     目标数字 target 不会在 deadends 之中。
     每个 deadends 和 target 中的字符串的数字会在 10,000 个可能的情况 '0000' 到 '9999' 中产生。
     
     
     解法：队列 + 图的广度优先遍历获取最短路径
     由题中条件：每次旋转都只能旋转一个拨轮的一位数字，可知，对于一个数字组合，例如 0000，
     它有以下的集中可能的邻近节点：
     [1000, 0100, 0010, 0001, 9000, 0900, 0090, 0009]
     这样就构成了一个图，然后就可以通过广度优先搜索的方式来获取0000到taget的最短路径步数了
     */
    func openLock(_ deadends: [String], _ target: String) -> Int {
        
        func getNext(_ str : String) -> [String] {
            var res = [String]()
            for i in str.indices {
                if let n = Int(String(str[i])) {
                    let new1 = (n+1) % 10
                    let new2 = n-1 < 0 ? 9 : n-1
                    var newStr1 = String(str)
                    var newStr2 = String(str)
                    let end = String.Index(encodedOffset: i.encodedOffset+1)
                    newStr1.replaceSubrange(i ..< end, with: "\(new1)")
                    newStr2.replaceSubrange(i ..< end, with: "\(new2)")
                    res.append(newStr1)
                    res.append(newStr2)

                } else {
                    return []
                }
            }
            return res
        }
        if target.isEmpty {
            return -1
        }
        let start = "0000"
        let deadendsSet = Set<String>(deadends)
        if deadendsSet.contains(start) {
            return -1
        }
        var visitedSet  = Set<String>()
        let queue = BasicQueue<String>()
        queue.enqueue(start)
        
        var step = 0
        // 广度优先遍历
        while !queue.isEmpty() {
            
            let size = queue.size()
            for _ in 0 ..< size {
                guard let curr = queue.front() else {
                    return -1
                }
                if curr == target {
                    return step
                }
                let nextNums = getNext(curr)
                for num in nextNums {
                    if deadendsSet.contains(num) {
                        continue
                    }
                    if !visitedSet.contains(num) {
                        queue.enqueue(num)
                        visitedSet.insert(num)
                    }
                }
                queue.dequeue()
            }
            step += 1
        }
        return -1
    }
    
    // MARK: -------------- 完全平方数 leetCode #279
    /*
     https://leetcode-cn.com/problems/perfect-squares/
     给定正整数 n，找到若干个完全平方数（比如 1, 4, 9, 16, ...）使得它们的和等于 n。你需要让组成和的完全平方数的个数最少。
     
     示例 1:
     输入: n = 12  输出: 3
     解释: 12 = 4 + 4 + 4.
     
     示例 2:
     输入: n = 13  输出: 2
     解释: 13 = 4 + 9.
     
     
     解法：
     三种方法：
     1. 抽象成图的最短路径的问题，并利用广度优先搜索的方式求解
     2. 动态规划
     3. 数学定理：四平方和定理。
     */
    
    /*
     解法1：
     从n到0的每一个数作为一个结点，如果两个数之间的差为一个完全平方数（1，4，9等等）则连接一条路径
     这样的话该问题就抽象成了求n到0的最短路径步数的问题。
     在获取某一结点k的邻接结点时，只需要从1到k遍历并求值a=k-i*i,如果a>0,则a是k的邻接结点将其加入队列，如果a==0，则求解结束，a<0则跳出循环
     参考：https://blog.csdn.net/hghggff/article/details/83756088
     */
    func numSquares_bfs(_ n: Int) -> Int {
        /* 抽象成图的最短路径的问题，并利用广度优先搜索的方式求解 */
        let queue = BasicQueue<Int>()
        var visited = Set<Int>()
        queue.enqueue(n)
        var step = 0
        while !queue.isEmpty() {
            let size = queue.size()
            for _ in 0 ..< size {
                let curr = queue.front()!
                queue.dequeue()
                if curr == 0 {
                    return step+1
                }
                for i in 1 ... curr {
                    let a = curr - i * i
                    if a > 0 {
                        if visited.contains(a) {
                            continue
                        }
                        queue.enqueue(a)
                        visited.insert(a)
                        
                    } else if a < 0 {
                        break
                        
                    } else { // a == 0
                        return step + 1
                    }
                }
            }
            step += 1
        }
        return step
    }
    
    /*
     解法2：
     动态规划，推到出状态转换方程之后解决。
     创建dp数组用来存储每个数的最小的完全平方数如ap[i] = k, 那么数字i的最小的完全平方数就是k。
     每一个数字（除了零以外）都可以由该数字大小数目的1相加而成，所以dp的数组中元素的初始值可以设置为i，即dp[i]=i（0则特殊，值为1）
     
     通过计算有如下现象：
     1 = 1 * 1
     2 = 1 + 1
     3 = 2 + 1
     4 = 2 * 2
     5 = 4 + 1
     6 = 5 + 1, 2 + 4
     7 = 6 + 1, 3 + 4
     8 = 7 + 1, 4 + 4
     9 = 8 + 1, 5 + 4、 9（9 + 0）
     10 = 9 + 1 , 6 + 4
     11 = 10 + 1, 7 + 4, 9 + 2
     12 = 11 + 1, 8 + 4, 9 + 3
     13 = 12 + 1, 9 + 4
     
     则
     dp[1]  = 1
     dp[2]  = dp[1] + 1 = 2
     dp[3]  = dp[2] + 1 = 2 + 1 = 3
     dp[4]  = 1
     dp[5]  = dp[4] + 1 = 1 + 1 = 2
     dp[6]  = min( dp[5] + 1, dp[2] + 1 )
     dp[7]  = min( dp[6] + 1, dp[3] + 1 )
     dp[8]  = min( dp[7] + 1, dp[4] + 1 )
     dp[9]  = 1
     dp[10] = min( dp[9] + 1 , dp[6] + 1 )
     dp[11] = min( dp[10] + 1, dp[7] + 1, dp[2] + 1 )
     dp[12] = min( dp[11] + 1, dp[8] + 1, dp[3] + 1 )
     dp[13] = min( dp[12] + 1, dp[9] + 1 )
     
     所以可以推到出：
     dp[n] = min ( dp[n - i * i] + 1, dp[n] )
     其中i为从1开始每次循环累加1，并且i*i <= n
     
     参考：
     https://segmentfault.com/a/1190000013363355
     https://blog.csdn.net/happyaaaaaaaaaaa/article/details/51584790
     https://www.cnblogs.com/rainxbow/p/9700908.html
     */
    func numSquares_dp(_ n: Int) -> Int {
        var dp = Array(repeating: 1, count: n+1)
        for i in 0 ... n {
            dp[i] = i > 1 ? i : 1
            var j = 1
            while j * j <= i {
                if j * j == i {
                    dp[i] = 1
                } else {
                    dp[i] = min(dp[i], dp[i-j*j] + 1)
                }
                j += 1
            }
        }
        return dp[n]
    }
    
    
    // MARK: -------------- 每日温度 leetCode #739
    /*
     https://leetcode-cn.com/problems/daily-temperatures/
     根据每日 气温 列表，请重新生成一个列表，对应位置的输入是你需要再等待多久温度才会升高的天数。
     如果之后都不会升高，请输入 0 来代替。
     
     例如，给定一个列表 temperatures = [73, 74, 75, 71, 69, 72, 76, 73]，你的输出应该是 [1, 1, 4, 2, 1, 1, 0, 0]。
     提示：气温 列表长度的范围是 [1, 30000]。每个气温的值的都是 [30, 100] 范围内的整数。
     */
    // 暴力解法：双重循环会超出时间限制
    func dailyTemperatures(_ T: [Int]) -> [Int] {
        guard T.isEmpty == false else { return [] }
        var res = Array(repeating: 0, count: T.count)
        for i in 0 ..< T.count-1 {
            for k in i+1 ..< T.count {
                if T[k] > T[i] {
                    res[i] = k - i
                    break
                }
            }
        }
        return res
    }
    
    /*
     使用 递减栈 解决：
     栈里只有递减元素，思路是这样的，我们遍历数组，如果栈不空，且当前数字大于栈顶元素，
     那么如果直接入栈的话就不是递减栈了。所以我们取出栈顶元素，那么由于当前数字大于栈顶元素的数字，
     而且一定是第一个大于栈顶元素的数，那么我们直接求出下标差就是二者的距离了，
     然后继续看新的栈顶元素，直到当前数字小于等于栈顶元素停止，然后将数字入栈，
     这样就可以一直保持递减栈，且每个数字和第一个大于它的数的距离也可以算出来了
     参考：https://blog.csdn.net/jackzhang_123/article/details/78894769
     */
    func dailyTemperatures_stack(_ T: [Int]) -> [Int] {
        guard T.isEmpty == false else { return [] }
        var res = Array(repeating: 0, count: T.count)
        let s = BasicStack<Int>()
        for i in 0 ..< T.count {
            while !s.isEmpty() && T[i] > T[s.top()!] {
                // 总是保持栈中栈底元素到栈顶元素是递减的
                // 如果当前元素大于栈顶元素，则pop之后将大的元素入栈
                let top = s.top()!
                s.pop()
                res[top] = i - top
            }
            s.push(i)
        }
        return res
    }
    
    // MARK: -------------- 逆波兰表达式求值 leetCode #150
    /*
     https://leetcode-cn.com/problems/evaluate-reverse-polish-notation/
     根据逆波兰表示法（https://baike.baidu.com/item/逆波兰式/128437），求表达式的值。
     
     有效的运算符包括 +, -, *, / 。每个运算对象可以是整数，也可以是另一个逆波兰表达式。
     
     说明：
     整数除法只保留整数部分。
     给定逆波兰表达式总是有效的。换句话说，表达式总会得出有效数值且不存在除数为 0 的情况。
     示例 1：
     
     输入: ["2", "1", "+", "3", "*"]    输出: 9
     解释: ((2 + 1) * 3) = 9
     示例 2：
     
     输入: ["4", "13", "5", "/", "+"]   输出: 6
     解释: (4 + (13 / 5)) = 6
     示例 3：
     
     输入: ["10", "6", "9", "3", "+", "-11", "*", "/", "*", "17", "+", "5", "+"]  输出: 22
     解释:
     ((10 * (6 / ((9 + 3) * -11))) + 17) + 5
     = ((10 * (6 / (12 * -11))) + 17) + 5
     = ((10 * (6 / -132)) + 17) + 5
     = ((10 * 0) + 17) + 5
     = (0 + 17) + 5
     = 17 + 5
     = 22
     */
    func evalRPN(_ tokens: [String]) -> Int {
        
        func makeOP(_ a : Int, _ op : String, _ b : Int) -> Int {
            switch op {
            case "+": return a+b
            case "-": return a-b
            case "*": return a*b
            default:  return a/b
            }
        }
        
        let opSet : Set<String> = ["+", "-", "*", "/"]
        if tokens.count == 1 && !opSet.contains(tokens[0]) {
            return Int(tokens[0]) ?? 0
        }
        let numStack = BasicStack<Int>()
        for c in tokens {
            let isNum = !opSet.contains(c)
            if isNum {
                numStack.push(Int(c) ?? 0)
            } else {
                let num1 = numStack.top() ?? 0
                numStack.pop()
                let num2 = numStack.top() ?? 0
                numStack.pop()
                numStack.push(makeOP(num2, c, num1))
            }
        }
        return numStack.top() ?? 0
    }
    
    // MARK: -------------- 克隆图 leetCode #133
    /*
     https://leetcode-cn.com/problems/clone-graph/
     克隆一张无向图，图中的每个节点包含一个 label （标签）和一个 neighbors （邻接点）列表 。
     
     OJ的无向图序列化：
     节点被唯一标记。 我们用 # 作为每个节点的分隔符，用 , 作为节点标签和邻接点的分隔符。
     
     例如，序列化无向图 {0,1,2#1,2#2,2}。 该图总共有三个节点, 被两个分隔符  # 分为三部分。
     第一个节点的标签为 0，存在从节点 0 到节点 1 和节点 2 的两条边。
     第二个节点的标签为 1，存在从节点 1 到节点 2 的一条边。
     第三个节点的标签为 2，存在从节点 2 到节点 2 (本身) 的一条边，从而形成自环。
     我们将图形可视化如下：
        1
       / \
      /   \
     0 --- 2
          / \
          \_/
     */
    /*
     dfs深度优先搜索+递归解法
     使用字典map来标识那些结点已经创建过了。以结点的label属性为key
     参考： https://blog.csdn.net/qq508618087/article/details/50806972
     */
    func cloneGraph_dfs(_ node : UndirectedGraphNode?) -> UndirectedGraphNode? {
        guard let node = node else { return nil }
        var map : [Int : UndirectedGraphNode] = [:]
        return _cloneGraph_dfs(node, map: &map)
    }
    
    private func _cloneGraph_dfs(_ node : UndirectedGraphNode?, map : inout [Int : UndirectedGraphNode]) -> UndirectedGraphNode? {
        guard let node = node else {
            return nil
        }
        if map[node.label] == nil {
            let newNode = UndirectedGraphNode(node.label)
            map[node.label] = newNode
            for subNode in node.neighbors {
                if let newSubNode = _cloneGraph_dfs(subNode, map: &map) {
                    newNode.neighbors.append(newSubNode)
                }
            }
        }
        return map[node.label]
    }
    
    /*
     bfs广度优先搜索+队列解法
     使用字典map来标识那些结点已经创建过了。以结点的label属性为key
     */
    func cloneGraph_bfs(_ node : UndirectedGraphNode?) -> UndirectedGraphNode? {
        guard let node = node else {
            return nil
        }
        var map : [Int : UndirectedGraphNode] = [:]
        let queue = BasicQueue<UndirectedGraphNode>()
        queue.enqueue(node)
        let newRoot = UndirectedGraphNode(node.label)
        map[node.label] = newRoot
        while !queue.isEmpty() {
            let currNode = queue.front()!
            let currRoot = map[currNode.label]!
            for subNode in currNode.neighbors {
                if let mappedSubNode = map[subNode.label] {
                    currRoot.neighbors.append(mappedSubNode)
                } else {
                    let newNode = UndirectedGraphNode(subNode.label)
                    map[subNode.label] = newNode
                    currRoot.neighbors.append(newNode)
                    queue.enqueue(subNode)
                }
            }
            queue.dequeue()
        }
        return map[node.label]
    }
    
    // MARK: -------------- 目标和 leetCode #494
    /*
     https://leetcode-cn.com/problems/target-sum/
     给定一个非负整数数组，a1, a2, ..., an, 和一个目标数，S。现在你有两个符号 + 和 -。
     对于数组中的任意一个整数，你都可以从 + 或 -中选择一个符号添加在前面。
     返回可以使最终数组和为目标数 S 的所有添加符号的方法数。
     
     示例 1:
     输入: nums: [1, 1, 1, 1, 1], S: 3    输出: 5
     解释:
     -1+1+1+1+1 = 3
     +1-1+1+1+1 = 3
     +1+1-1+1+1 = 3
     +1+1+1-1+1 = 3
     +1+1+1+1-1 = 3
     一共有5种方法让最终目标和为3。
     
     注意:
     数组的长度不会超过20，并且数组中的值全为正数。
     初始的数组的和不会超过1000。
     保证返回的最终结果为32位整数。
     */
    func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        //初始从0开始，这个0不在nums数组中，只是作为一个临时的根节点，所以step初值为-1
        return _findTargetSumWays(node: 0, target: S, step: -1, nums: nums)
    }
    
    private func _findTargetSumWays(node : Int , target : Int, step : Int, nums : [Int]) -> Int {
        // 相当于二叉树的深度优先搜索（左子树为加法，右子树为减法。或者相反也可以）
        let step = step + 1
        let num = nums[step]
        if step >= nums.count-1 {
            let count1 = (node+num == target) ? 1 : 0
            let count2 = (node-num == target) ? 1 : 0
            return count1 + count2
        }
        let count1 = _findTargetSumWays(node: node-num, target: target, step: step, nums: nums)
        let count2 = _findTargetSumWays(node: node+num, target: target, step: step, nums: nums)
        return count1 + count2
    }
    
    // MARK: -------------- 用栈实现队列 leetCode #232
    /*
     https://leetcode-cn.com/problems/target-sum/
     使用栈实现队列的下列操作：
     
     push(x) -- 将一个元素放入队列的尾部。
     pop() -- 从队列首部移除元素。
     peek() -- 返回队列首部的元素。
     empty() -- 返回队列是否为空。
     
     示例:
     MyQueue queue = new MyQueue();
     queue.push(1);
     queue.push(2);
     queue.peek();  // 返回 1
     queue.pop();   // 返回 1
     queue.empty(); // 返回 false
     
     说明:
     你只能使用标准的栈操作 -- 也就是只有 push to top, peek/pop from top, size, 和 is empty 操作是合法的。
     你所使用的语言也许不支持栈。你可以使用 list 或者 deque（双端队列）来模拟一个栈，只要是标准的栈操作即可。
     假设所有操作都是有效的 （例如，一个空的队列不会调用 pop 或者 peek 操作）。
     
     注意:
     数组的长度不会超过20，并且数组中的值全为正数。
     初始的数组的和不会超过1000。
     保证返回的最终结果为32位整数。
     */
    
    
    //MARK: - UndirectedGraphNode for solution 133
    class UndirectedGraphNode {
        var label : Int = -1
        var neighbors : [UndirectedGraphNode] = []
        init(_ label : Int) {
            self.label = label
        }
    }
}


