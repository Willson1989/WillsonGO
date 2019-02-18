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
    
    
    // MARK: -------------- 打开转盘锁 leetCode #739
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
        class BasicStack {
            
            fileprivate var data = [Int]()
            
            func push(_ x: Int) {
                data.append(x)
            }
            
            func pop() {
                if data.isEmpty {
                    return
                }
                data.removeLast()
            }
            
            func top() -> Int? {
                if data.isEmpty {
                    return nil
                }
                return data.last!
            }
            
            func isEmpty() -> Bool {
                return data.count <= 0
            }
        }
        guard T.isEmpty == false else { return [] }
        var res = Array(repeating: 0, count: T.count)
        let s = BasicStack()
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

    
    //MARK: - Stack for solutions
    class BasicStack<T : Comparable> {
        
        fileprivate var minItems = [T]()
        fileprivate var data = [T]()
        
        init() {
            
        }
        
        func push(_ x: T) {
            if data.isEmpty {
                minItems.append(x)
                data.append(x)
            } else {
                data.append(x)
                if x <= minItems.last! {
                    minItems.append(x)
                }
            }
        }
        
        func pop() {
            if data.isEmpty {
                return
            }
            let last = data.last!
            let min  = minItems.last!
            if last == min {
                minItems.removeLast()
            }
            data.removeLast()
        }
        
        func top() -> T? {
            if data.isEmpty {
                return nil
            }
            return data.last!
        }
        
        func getMin() -> T?{
            if minItems.isEmpty {
                return nil
            }
            return minItems.last!
        }
        
        func isEmpty() -> Bool {
            return data.count <= 0
        }
    }
    
    //MARK: - Queue for solutions
    class BasicQueue<T> {
        
        fileprivate var queueArr : [T]
        
        public init() {
            queueArr = [T]()
        }
        
        public func front() -> T? {
            if self.isEmpty() == true {
                return nil
            }
            return self.queueArr.first
        }
        
        public func enqueue(_ obj : T?) {
            if obj == nil {
                return
            }
            self.queueArr.append(obj!)
        }
        
        public func dequeue(){
            if self.isEmpty() == true {
                return
            }
            self.queueArr.removeFirst()
        }
        
        public func isEmpty() -> Bool {
            return self.queueArr.count == 0
        }
        
        public func size() -> Int {
            return self.queueArr.count
        }
    }


}


