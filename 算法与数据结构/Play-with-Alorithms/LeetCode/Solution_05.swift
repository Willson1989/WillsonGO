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
    func numSquares(_ n: Int) -> Int {
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


