//
//  Solution_02.swift
//  Play-with-Alorithms
//
//  Created by 朱金倩 on 2018/8/21.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

extension Solution {
    
    /*
     leetCode #203
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
    
    /*
     leetCode #54
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
    
    /*
     leetCode #59
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
    
    
    
    
    
    
    
    

}
