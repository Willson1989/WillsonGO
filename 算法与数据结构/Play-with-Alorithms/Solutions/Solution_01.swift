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
    
    func search(_ nums: [Int], _ target: Int) -> Int {
        
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
}
