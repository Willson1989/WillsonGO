//
//  Solution_02.swift
//  Play-with-Alorithms
//
//  Created by 朱金倩 on 2018/8/21.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

extension Solution {
    
    // MARK: -------------- leetCode #203
    /*
     https://leetcode-cn.com/problems/remove-linked-list-elements/description/
     删除链表中等于给定值 val 的所有节点。
     示例:
     输入: 1->2->6->3->4->5->6, val = 6
     输出: 1->2->3->4->5
     */
    func removeListElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        
        if head == nil {
            return nil
        }
        var newHead = head
        while newHead != nil && newHead!.val == val {
            newHead = newHead?.next
        }
        var p = newHead
        var q = p?.next
        while q != nil {
            if q!.val != val {
                p?.next = q
                p = p?.next
            }
            q = q?.next
        }
        if let next = p?.next {
            if next.val == val {
                p?.next = nil
            }
        }
        return newHead
    }
    
    // MARK: -------------- leetCode #54
    /*
     https://leetcode-cn.com/problems/spiral-matrix/description/
     参考： https://blog.csdn.net/u011643312/article/details/71082975
     给定一个包含 m x n 个元素的矩阵（m 行, n 列），请按照顺时针螺旋顺序，返回矩阵中的所有元素。
     
     示例 1:
     输入:
     [
     [ 1, 2, 3 ],
     [ 4, 5, 6 ],
     [ 7, 8, 9 ]
     ]
     输出: [1,2,3,6,9,8,7,4,5]
     
     示例 2:
     输入:
     [
     [1, 2, 3, 4],
     [5, 6, 7, 8],
     [9,10,11,12]
     ]
     输出: [1,2,3,4,8,12,11,10,9,5,6,7]
     */
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        if matrix.isEmpty {
            return []
        }
        var tempCount = matrix[0].count
        for arr in matrix {
            if arr.isEmpty || tempCount != arr.count {
                return []
            }
            tempCount = arr.count
        }
        
        var res = [Int]()
        let r = matrix.count
        let c = matrix[0].count
        var total = r * c
        
        var min_c = 0, min_r = 0
        var max_c = c, max_r = r
        
        while total > 0 {
            var i = min_r , j = min_c
            while total > 0 && j < max_c {
                res.append(matrix[i][j])
                total -= 1
                j += 1
            }
            j -= 1
            i += 1
            
            while total > 0 && i < max_r {
                res.append(matrix[i][j])
                total -= 1
                i += 1
            }
            i -= 1
            j -= 1
            
            while total > 0 && j >= min_c {
                res.append(matrix[i][j])
                total -= 1
                j -= 1
            }
            j += 1
            i -= 1
            
            while total > 0 && i > min_r  {
                res.append(matrix[i][j])
                total -= 1
                i -= 1
            }
            i += 1
            j += 1
            min_c += 1
            min_r += 1
            max_c -= 1
            max_r -= 1
        }
        return res
    }
    
    // MARK: -------------- leetCode #59
    /*
     https://leetcode-cn.com/problems/spiral-matrix-ii/description/
     参考：可以参考#54，使用螺旋打印矩阵的逆向思维
     给定一个正整数 n，生成一个包含 1 到 n2 所有元素，且元素按顺时针顺序螺旋排列的正方形矩阵。
     
     示例:
     输入: 3
     输出:
     [
     [ 1, 2, 3 ],
     [ 8, 9, 4 ],
     [ 7, 6, 5 ]
     ]
     */
    func generateMatrix(_ n: Int) -> [[Int]] {
        
        if n == 0 { return [[Int]]()}
        
        var res = Array(repeating: Array(repeating: -1, count: n), count: n)
        let total = n * n
        var sum = 0
        
        var min_c = 0, min_r = 0
        var max_c = n, max_r = n
        
        while sum < total {
            
            var i = min_r , j = min_c
            //left -> right
            while sum < total && j < max_c {
                sum += 1
                res[i][j] = sum
                j += 1
            }
            j -= 1
            i += 1
            
            //top -> bottom
            while sum < total && i < max_r {
                sum += 1
                res[i][j] = sum
                i += 1
            }
            i -= 1
            j -= 1
            
            //right -> left
            while sum < total && j >= min_c {
                sum += 1
                res[i][j] = sum
                j -= 1
            }
            j += 1
            i -= 1
            
            //bottom -> up
            while sum < total && i > min_r {
                sum += 1
                res[i][j] = sum
                i -= 1
            }
            i += 1
            j += 1
            min_c += 1
            min_r += 1
            max_c -= 1
            max_r -= 1
            
        }
        return res
    }
    
    // MARK: -------------- leetCode #171
    /*
     https://leetcode-cn.com/problems/excel-sheet-column-number/description/
     给定一个Excel表格中的列名称，返回其相应的列序号。
     
     例如，
     A -> 1
     B -> 2
     C -> 3
     ...
     Z -> 26
     AA -> 27
     AB -> 28
     ...
     示例 1:
     输入: "A"  输出: 1
     
     示例 2:
     输入: "AB"  输出: 28
     
     示例 3:
     输入: "ZY"  输出: 701
     */
    func titleToNumber(_ s: String) -> Int {
        
        if s.count == 0 {
            return -1
        }
        var s = s.uppercased()
        func getNum(_ c : Character) -> Int {
            let a : [Character] = ["A","B","C","D","E","F","G","H","I","J","K","L","M",
                                   "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
            return (a.index(of: c) ?? -1) + 1
        }
        
        var sum = 0
        for i in stride(from: s.count-1, through: 0, by: -1) {
            
            let c = s[s.index(s.startIndex, offsetBy: i)]
            let num = getNum(c)
            if num <= 0 {
                return -1
            }
            var d = 1
            let k = s.count - 1 - i
            if k > 0 {
                for _ in 0 ..< k {
                    d *= 26
                }
                sum += (num * d)
            } else {
                sum += num
            }
        }
        
        return sum
    }
    
    // MARK: -------------- leetCode #168
    /*
     https://leetcode-cn.com/problems/excel-sheet-column-title/description/
     给定一个正整数，返回它在 Excel 表中相对应的列名称。
     
     例如，
     1 -> A
     2 -> B
     3 -> C
     ...
     26 -> Z
     27 -> AA
     28 -> AB
     ...
     示例 1:
     输入: 1   输出: "A"
     
     示例 2:
     输入: 28  输出: "AB"
     
     示例 3:
     输入: 701 输出: "ZY"
     */
    func convertToTitle(_ n: Int) -> String {
        func getChar(_ n : Int) -> String {
            let a : [String] = ["A","B","C","D","E","F","G","H","I","J","K","L","M",
                                "N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
            if n < 0 || n >= a.count {
                return ""
            }
            return a[n]
        }
        var res = ""
        //由于数字是从1开始的所以在下一次计算开始之前要减去1
        var n = n - 1
        while n >= 0  {
            let temp = n % 26
            let c = getChar(temp)
            res = c + res
            n /= 26
            n -= 1
        }
        return res
    }
    
    // MARK: -------------- leetCode #66
    /*
     https://leetcode-cn.com/problems/plus-one/description/
     给定一个由整数组成的非空数组所表示的非负整数，在该数的基础上加一。
     最高位数字存放在数组的首位， 数组中每个元素只存储一个数字。 你可以假设除了整数 0 之外，这个整数不会以零开头。
     
     示例 1:
     输入: [1,2,3]    输出: [1,2,4]
     解释: 输入数组表示数字 123。
     
     示例 2:
     输入: [4,3,2,1]  输出: [4,3,2,2]
     解释: 输入数组表示数字 4321。
     
     示例 3:
     输入: [9,9,9]  输出: [1,0,0,0]
     解释: 输入数组表示数字 999。
     */
    func plusOne(_ arr : [Int]) -> [Int] {
        if arr.isEmpty {
            return []
        }
        var res = [Int]()
        var add = 0
        var k = 0
        for i in stride(from: arr.count-1, through: 0, by: -1) {
            if i == arr.count-1 {
                k = arr[i] + 1
            } else {
                k = arr[i]
            }
            let sum =  k + add
            let temp = sum % 10
            add = sum >= 10 ? 1 : 0
            res.insert(temp, at: 0)
        }
        if add == 1 {
            res.insert(1, at: 0)
        }
        return res
    }
    
    // MARK: -------------- leetCode #840
    /*
     https://leetcode-cn.com/problems/magic-squares-in-grid/description/
     3 x 3 的幻方是一个填充有从 1 到 9 的不同数字的 3 x 3 矩阵，其中每行，每列以及两条对角线上的各数之和都相等。
     给定一个由整数组成的 N × N 矩阵，其中有多少个 3 × 3 的 “幻方” 子矩阵？（每个子矩阵都是连续的）。
     
     示例 1:
     输入:
     [[4,3,8,4],
      [9,5,1,9],
      [2,7,6,2]]
     输出: 1

     解释:
     下面的子矩阵是一个 3 x 3 的幻方：
     438
     951
     276
     
     而这一个不是：
     384
     519
     762
     总的来说，在本示例所给定的矩阵中只有一个 3 x 3 的幻方子矩阵。
     */
    func numMagicSquaresInside(_ grid: [[Int]]) -> Int {
        func isMagic(_ m : [[Int]], _ i : Int, _ j : Int) -> Bool {
            for p in i ... i+2 {
                for q in j ... j+2 {
                    if m[p][q] > 9 || m[p][q] < 1 {return false}
                }
            }
            let arr = [(m[i][j] + m[i+1][j] + m[i+2][j]),
                       (m[i][j] + m[i+1][j+1] + m[i+2][j+2]),
                       (m[i][j+2] + m[i][j+1] + m[i][j]),
                       (m[i][j+2] + m[i+1][j+1] + m[i+2][j]),
                       (m[i+2][j] + m[i+2][j+1] + m[i+2][j+2]),
                       (m[i+2][j+2] + m[i+1][j+2] + m[i][j+2])]
            for i in 1 ..< arr.count {
                if arr[i] != arr[0] { return false }
            }
            return true
        }
        
        var total = 0
        let row = grid.count
        if row < 3 { return 0 }
        let column = grid[0].count
        if column < 3 { return 0 }
        
        for i in 0 ..< row - 2{
            for j in 0 ..< column - 2 {
                if isMagic(grid, i, j) {
                    total += 1
                }
            }
        }
        return total
    }
    
    // MARK: -------------- leetCode #70
    /*
     https://leetcode-cn.com/problems/climbing-stairs/description/
     假设你正在爬楼梯。需要 n 阶你才能到达楼顶。 每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？
     注意：给定 n 是一个正整数。
     
     示例 1：
     输入： 2 输出： 2
     解释： 有两种方法可以爬到楼顶。
     1.  1 阶 + 1 阶
     2.  2 阶
     
     示例 2：
     输入： 3 输出： 3
     解释： 有三种方法可以爬到楼顶。
     1.  1 阶 + 1 阶 + 1 阶
     2.  1 阶 + 2 阶
     3.  2 阶 + 1 阶
     */
    func climbStairs(_ n: Int) -> Int {
        
        var cache : [Int] = Array(repeating: 0, count: n+1)
        func _step(_ n : Int, _ cache : inout [Int]) -> Int {
            if n < 1 { return 0 }
            if n == 1 {
                cache[1] = 1
                return 1
            }
            if n == 2 {
                cache[2] = 2
                return 2
            }
            if cache[n] > 0 {
                return cache[n]
            }
            cache[n] = _step(n-1, &cache) + _step(n-2, &cache)
            return cache[n]
        }
        return _step(n, &cache)
    }
    
    // MARK: -------------- leetCode #852
    /*
     https://leetcode-cn.com/problems/peak-index-in-a-mountain-array/description/
     我们把符合下列属性的数组 A 称作山脉：
     
     A.length >= 3
     存在 0 < i < A.length - 1 使得A[0] < A[1] < ... A[i-1] < A[i] > A[i+1] > ... > A[A.length - 1]
     给定一个确定为山脉的数组，返回任何满足 A[0] < A[1] < ... A[i-1] < A[i] > A[i+1] > ... > A[A.length - 1] 的 i 的值。

     示例 1：
     输入：[0,1,0]   输出：1
     
     示例 2：
     输入：[0,2,1,0] 输出：1

     */
    func peakIndexInMountainArray(_ A: [Int]) -> Int {
        
        if A.isEmpty {
            return -1
        }
        var pi = 0
        for i in 1 ..< A.count {
            if A[pi] < A[i] {
                pi = i
            }
        }
        return pi
    }
}
