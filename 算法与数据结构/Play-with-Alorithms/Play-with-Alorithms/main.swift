//
//  main.swift
//  Play-with-Alorithms
//
//  Created by 朱金倩 on 2018/8/17.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

import Foundation

func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    
    var res = [Int]()
    let count = min(nums1.count, nums2.count)
    let arr = nums1.count > nums2.count ? nums2 : nums1
    for i in 0 ..< count {
        let n = arr[i]
        if nums1.contains(n) && nums2.contains(n) && !res.contains(n){
            res.append(n)
        }
    }
    return res
}

func intersection_1(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    return Array(Set<Int>(nums1).intersection(Set<Int>(nums2)))
}

let s = Solution()

let input = [2,1]
print("containsNearbyDuplicate : ",s.containsNearbyAlmostDuplicate(input, 1,1))


let island : [[Character]] =
    [
        []
]
//[
// ["1","1","1","1","0","1","1","1"],
// ["1","1","1","1","0","1","1","1"],
// ["1","1","0","0","0","0","0","0"],
// ["1","1","0","1","1","0","1","1"],
// ["1","1","0","1","1","0","0","1"],
// ["1","1","0","1","1","0","0","1"],
//]

let inininin = [73,74,75,71,69,72,76,73]
//let inininin = [Int]()
print("dailyTemperatures : ",s.dailyTemperatures_stack(inininin))




